import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redux_comp/actions/admin/helper_functions/build_data.dart';
import 'package:redux_comp/models/admin/app_metrics/line_chart_model.dart';
import 'package:redux_comp/models/admin/app_metrics/metrics_model.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetSessionMetricsAction extends ReduxAction<AppState> {
  final int? hoursAgo;
  final int? period;
  GetSessionMetricsAction({this.hoursAgo, this.period});
  @override
  Future<AppState?> reduce() async {
    int p = period ?? state.admin.userMetrics.sessionMetrics?.period ?? 60;
    int h = hoursAgo ?? state.admin.userMetrics.sessionMetrics?.time ?? 12;

    DateTime end = DateTime.now().subtract(const Duration(hours: 2));
    DateTime start = end.subtract(Duration(hours: h));
    int paramsPeriod = p * 60;

    var params = {
      "EndTime": "${end.toIso8601String()}Z",
      "MetricDataQueries": [
        {
          "Id": 'sessionStart',
          "MetricStat": {
            "Metric": {
              "Dimensions": [],
              "MetricName": '_session.start',
              "Namespace": 'SessionEvents'
            },
            "Period": '$paramsPeriod',
            "Stat": 'Sum',
          },
          "ReturnData": true
        },
        {
          "Id": 'sessionStop',
          "MetricStat": {
            "Metric": {
              "Dimensions": [],
              "MetricName": '_session.stop',
              "Namespace": 'SessionEvents'
            },
            "Period": '$paramsPeriod',
            "Stat": 'Sum',
          },
          "ReturnData": true
        },
      ],
      "StartTime": "${start.toIso8601String()}Z",
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
      List<LineChartModel> sessions = [];
      int sessionStarts = 0;
      int sessionStops = 0;

      for (var data in values) {
        switch (data["Id"]) {
          case "sessionStart":
            sessions.add(LineChartModel(
                data: buildData(data, start, end, p),
                color: Colors.green,
                label: 'Session Start'));

            for (int val in data["Values"]) {
              sessionStarts += val;
            }
            break;
          case "sessionStop":
            sessions.add(LineChartModel(
                data: buildData(data, start, end, p),
                color: Colors.red,
                label: 'Session Stop'));
             for (int val in data["Values"]) {
              sessionStops += val;
            }
            break;
        }
      }

      Map<String, List<LineChartModel>> graphs =
          state.admin.userMetrics.sessionMetrics?.graphs ?? {};
      graphs.addEntries(
        [
          MapEntry(
            "sessions", //key
            sessions,
          )
        ],
      );


      return state.copy(
        admin: state.admin.copy(
          userMetrics: state.admin.userMetrics.copy(
            activeSessions: sessionStarts-sessionStops,
            sessionMetrics: state.admin.userMetrics.sessionMetrics?.copy(
                  period: p,
                  time: h,
                  graphs: graphs,
                ) ??
                MetricsModel(
                  period: p,
                  time: h,
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
}
