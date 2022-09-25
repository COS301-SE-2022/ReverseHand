import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/admin/helper_functions/build_data.dart';
import 'package:redux_comp/models/admin/app_metrics/line_chart_model.dart';
import 'package:redux_comp/models/admin/app_metrics/metrics_model.dart';

import '../../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class GetDbMetricsAction extends ReduxAction<AppState> {
  final int hoursAgo;
  final int period;
  GetDbMetricsAction({required this.hoursAgo, required this.period});
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
          "Id": 'readCons',
          /* required */
          "MetricStat": {
            "Metric": {
              /* required */
              "Dimensions": [
                {
                  "Name": 'TableName',
                  /* required */
                  "Value": 'ReverseHand' /* required */
                },
                /* more items */
              ],
              "MetricName": 'ConsumedReadCapacityUnits',
              "Namespace": 'AWS/DynamoDB'
            },
            "Period": '$paramsPeriod',
            /* required */
            "Stat": 'Average', /* required */
          },
          "ReturnData": true
        },
        {
          "Id": 'readProv',
          /* required */
          "MetricStat": {
            "Metric": {
              /* required */
              "Dimensions": [
                {
                  "Name": 'TableName',
                  /* required */
                  "Value": 'ReverseHand' /* required */
                },
                /* more items */
              ],
              "MetricName": 'ProvisionedReadCapacityUnits',
              "Namespace": 'AWS/DynamoDB'
            },
            "Period": '$paramsPeriod',
            /* required */
            "Stat": 'Average', /* required */
          },
          "ReturnData": true
        },
        {
          "Id": 'writeCons',
          /* required */
          "MetricStat": {
            "Metric": {
              /* required */
              "Dimensions": [
                {
                  "Name": 'TableName',
                  /* required */
                  "Value": 'ReverseHand' /* required */
                },
                /* more items */
              ],
              "MetricName": 'ConsumedWriteCapacityUnits',
              "Namespace": 'AWS/DynamoDB'
            },
            "Period": '$paramsPeriod',
            /* required */
            "Stat": 'Average', /* required */
          },
          "ReturnData": true
        },
        {
          "Id": 'writeProv',
          /* required */
          "MetricStat": {
            "Metric": {
              /* required */
              "Dimensions": [
                {
                  "Name": 'TableName',
                  /* required */
                  "Value": 'ReverseHand' /* required */
                },
                /* more items */
              ],
              "MetricName": 'ProvisionedWriteCapacityUnits',
              "Namespace": 'AWS/DynamoDB'
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
      List<LineChartModel> dbRead = [];
      List<LineChartModel> dbWrite = [];

      for (var data in values) {
        switch (data["Id"]) {
          case "readCons":
            dbRead.add(LineChartModel(
                data: buildData(data, start, end, period),
                color: Colors.orange,
                label: 'Read Capacity'));
            break;
          case "readProv":
            dbRead.add(LineChartModel(
                data: buildData(data, start, end, period),
                color: Colors.red,
                label: 'Provisioned Capacity'));
            break;
          case "writeCons":
            dbWrite.add(LineChartModel(
                data: buildData(data, start, end, period),
                color: Colors.orange,
                label: 'Write Capacity'));
            break;
          case "writeProv":
            dbWrite.add(LineChartModel(
                data: buildData(data, start, end, period),
                color: Colors.red,
                label: 'Provisioned Capacity'));
            break;
        }
      }

      Map<String, List<LineChartModel>> graphs =
          state.admin.appMetrics.databaseMetrics?.graphs ?? {};
      graphs.addEntries(
        [
          MapEntry(
            "dbReadData", //key
            dbRead,
          ),
          MapEntry(
            "dbWriteData",
            dbWrite,
          )
        ],
      );
      return state.copy(
        admin: state.admin.copy(
          appMetrics: state.admin.appMetrics.copy(
            databaseMetrics: state.admin.appMetrics.databaseMetrics?.copy(
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
