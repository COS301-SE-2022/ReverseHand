import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/admin/helper_functions/build_line_data.dart';
import 'package:redux_comp/models/admin/app_metrics/line_chart_model.dart';
import 'package:redux_comp/models/admin/app_metrics/metrics_model.dart';

import '../../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class GetAuthMetricsAction extends ReduxAction<AppState> {
  final int hoursAgo;
  final int period;
  GetAuthMetricsAction({required this.hoursAgo, required this.period});
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
          "Id": 'signUpSuccesses',
          /* required */
          "MetricStat": {
            "Metric": {
              /* required */
              "Dimensions": [
                {
                  "Name": 'UserPool',
                  /* required */
                  "Value": 'eu-west-1_QpsSD87RL' /* required */
                },
                {
                  "Name": 'UserPoolClient',
                  /* required */
                  "Value": '5sjgir76gfiuar2iu2t6v4ml5a' /* required */
                },
                /* more items */
              ],
              "MetricName": 'SignUpSuccesses',
              "Namespace": 'AWS/Cognito'
            },
            "Period": '$paramsPeriod',
            /* required */
            "Stat": 'Sum', /* required */
          },
          "ReturnData": true
        },
        {
          "Id": 'tokenRefreshSuccesses',
          /* required */
          "MetricStat": {
            "Metric": {
              /* required */
              "Dimensions": [
                {
                  "Name": 'UserPool',
                  /* required */
                  "Value": 'eu-west-1_QpsSD87RL' /* required */
                },
                {
                  "Name": 'UserPoolClient',
                  /* required */
                  "Value": '5sjgir76gfiuar2iu2t6v4ml5a' /* required */
                },
                /* more items */
              ],
              "MetricName": 'TokenRefreshSuccesses',
              "Namespace": 'AWS/Cognito'
            },
            "Period": '$paramsPeriod',
            /* required */
            "Stat": 'Sum', /* required */
          },
          "ReturnData": true
        },
        {
          "Id": 'signInSuccesses',
          /* required */
          "MetricStat": {
            "Metric": {
              /* required */
              "Dimensions": [
                {
                  "Name": 'UserPool',
                  /* required */
                  "Value": 'eu-west-1_QpsSD87RL' /* required */
                },
                {
                  "Name": 'UserPoolClient',
                  /* required */
                  "Value": '5sjgir76gfiuar2iu2t6v4ml5a' /* required */
                },
                /* more items */
              ],
              "MetricName": 'SignInSuccesses',
              "Namespace": 'AWS/Cognito'
            },
            "Period": '$paramsPeriod',
            /* required */
            "Stat": 'Sum', /* required */
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
      List<LineChartModel> authMetrics = [];

      for (var data in values) {
        switch (data["Id"]) {
          case "signInSuccesses":
            authMetrics.add(
              LineChartModel(
                data: buildData(data, start, end, period),
                color: Colors.redAccent,
                label: data["Id"],
              ),
            );
            break;
          case "signUpSuccesses":
            authMetrics.add(
              LineChartModel(
                data: buildData(data, start, end, period),
                color: Colors.green,
                label: data["Id"],
              ),
            );
            break;
          case "tokenRefreshSuccesses":
            authMetrics.add(
              LineChartModel(
                data: buildData(data, start, end, period),
                color: Colors.purpleAccent,
                label: data["Id"],
              ),
            );
            break;
        }
      }

      Map<String, List<LineChartModel>> graphs =
          state.admin.appMetrics.authMetrics?.graphs ?? {};
      graphs.addEntries(
        [MapEntry("authMetrics", authMetrics)],
      );
      return state.copy(
        admin: state.admin.copy(
          appMetrics: state.admin.appMetrics.copy(
            authMetrics: state.admin.appMetrics.authMetrics?.copy(
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
