import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_metrics/metric_chart_model.dart';

import '../app_state.dart';
import 'package:async_redux/async_redux.dart';

class GetDbWriteMetricsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    DateTime end = DateTime.now();
    DateTime start = end.subtract(const Duration(hours: 12));

    // debugPrint(end.toIso8601String());

    var params = {
      "EndTime": "${end.toIso8601String()}Z",
      /* required */
      "MetricDataQueries": [
        /* required */
        {
          "Id": 'm1',
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
            "Period": '300',
            /* required */
            "Stat": 'Average', /* required */
          },
          "ReturnData": true
        },
        /* more items */
      ],
      "StartTime": "${start.toIso8601String()}Z",
      /* required */
      "LabelOptions": {
        "Timezone": "+0200",
      },
      "MaxDatapoints": 144,
      "ScanBy": "TimestampDescending"
    };

    // debugPrint();
    

    String graphQLDoc = '''query {
      getMetrics(params: "${jsonEncode(params).replaceAll('"', '\\"')}")
    }
    ''';

    debugPrint(graphQLDoc);

    final request = GraphQLRequest(document: graphQLDoc);
    try {
      final response = await Amplify.API.query(request: request).response;
      final data = jsonDecode(response.data)["getMetrics"];

      return state.copy(
        admin: state.admin.copy(
          appMetrics: state.admin.appMetrics.copy(
            dbWriteGraph: MetricChartModel.fromJson(data)
          )
        )
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
// query {
//       getMetrics(params: "{\"EndTime\":\"2022-09-15T13:12:08.273989Z\",\"MetricDataQueries\":[{\"Id\":\"m1\",\"MetricStat\":{\"Metric\":{\"Dimensions\":[{\"Name\":\"TableName\",\"Value\":\"ReverseHand\"}],\"MetricName\":\"ConsumedReadCapacityUnits\",\"Namespace\":\"AWS/DynamoDB\"},\"Period\":\"300\",\"Stat\":\"Average\"},\"ReturnData\":true}],\"StartTime\":\"2022-09-15T01:12:08.273989Z\",\"LabelOptions\":{\"Timezone\":\"+0200\"},\"MaxDatapoints\":144,\"ScanBy\":\"TimestampDescending\"}")
//     }