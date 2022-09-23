import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_metrics/line_chart_model.dart';
import 'package:redux_comp/models/admin/app_metrics/metrics_model.dart';
import 'package:redux_comp/models/admin/app_metrics/observation_model.dart';

import '../../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class GetApiMetricsAction extends ReduxAction<AppState> {
  final int hoursAgo;
  final int period;
  GetApiMetricsAction({required this.hoursAgo, required this.period});
  @override
  Future<AppState?> reduce() async {
    DateTime end = DateTime.now().subtract(const Duration(hours: 2));
    DateTime start = end.subtract(Duration(hours: hoursAgo));
    int paramsPeriod = period * 60;

    var params = {
      "EndTime": "${end.toIso8601String()}Z",
      /* required */
      "MetricDataQueries": [
        /* required */
        {
          "Id": 'apiLatency',
          /* required */
          "MetricStat": {
            "Metric": {
              /* required */
              "Dimensions": [
                {
                  "Name": 'GraphQLAPIId',
                  /* required */
                  "Value": '5z3zb5wq5zfybbir5y4rmpvhvi' /* required */
                },
                /* more items */
              ],
              "MetricName": 'Latency',
              "Namespace": 'AWS/AppSync'
            },
            "Period": '$paramsPeriod',
            /* required */
            "Stat": 'Average', /* required */
          },
          "ReturnData": true
        },
      ],
      "StartTime": "${start.toIso8601String()}Z",
      /* required */
      "LabelOptions": {
        "Timezone": "+0200",
      },
      "ScanBy": "TimestampAscending"
    };

    String graphQLDoc = '''query {
      getMetrics(params: "${jsonEncode(params).replaceAll('"', '\\"')}")
    }
    ''';

    final request = GraphQLRequest(document: graphQLDoc);
    try {
      final response = await Amplify.API.query(request: request).response;
      final data = jsonDecode(jsonDecode(
          response.data)["getMetrics"]); //resp is a json encoded json string
      final List<dynamic> values = data;
      //build & group charts in list's
      List<LineChartModel> apiLatency = [];

      for (var data in values) {
        switch (data["Id"]) {
          case "apiLatency":
            apiLatency.add(LineChartModel(
                data: buildData(data),
                color: Colors.orange,
                label: 'Latency'));
            break;
          
        }
      }

      Map<String, List<LineChartModel>> graphs =
          state.admin.appMetrics.apiMetrics?.graphs ?? {};
      graphs.addEntries(
        [
          MapEntry(
            "apiLatency", //key
            apiLatency,
          )         
        ],
      );
      return state.copy(
        admin: state.admin.copy(
          appMetrics: state.admin.appMetrics.copy(
            apiMetrics: state.admin.appMetrics.apiMetrics?.copy(
                  period: period,
                  time: hoursAgo,
                  graphs: graphs,
                ) ??
                MetricsModel(
                  period: period,
                  time: hoursAgo,
                  graphs: graphs,
                ),
          ),
        ),
      );
    } on ApiException catch (e) {
      debugPrint(e.message);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // @override
  // void before() => dispatch(WaitAction.add("load_db_read"));

  // @override
  // void after() => dispatch(WaitAction.remove("load_db_read"));
}

List<ObservationModel> buildData(obj) {
  int length = obj["Values"].length;

  List<ObservationModel> data = [];
  int i = length;
  while (i > 0) {
    i--;
    data.add(ObservationModel(
        time: (obj["Timestamps"][i]).substring(11, 16),
        value: obj['Values'][i]));
  }
  return data;
}
