import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_metrics/line_chart_model.dart';
import 'package:redux_comp/models/admin/observation_model.dart';

import '../../../app_state.dart';
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
          "Id": 'r1',
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
            "Period": '300',
            /* required */
            "Stat": 'Average', /* required */
          },
          "ReturnData": true
        },
        {
          "Id": 'p1',
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

    String graphQLDoc = '''query {
      getMetrics(params: "${jsonEncode(params).replaceAll('"', '\\"')}")
    }
    ''';

    debugPrint(graphQLDoc);

    final request = GraphQLRequest(document: graphQLDoc);
    try {
      final response = await Amplify.API.query(request: request).response;
      final data = jsonDecode(jsonDecode(
          response.data)["getMetrics"]); //resp is a json encoded json string
      final List<dynamic> values = data;
      return state.copy(
          admin: state.admin.copy(
              appMetrics: state.admin.appMetrics.copy(
        dbWriteData: [
          LineChartModel(
              data: buildData(values[0]),
              color: Colors.orange,
              label: 'Write Capacity'),
          LineChartModel(
              data: buildData(values[1]),
              color: Colors.red,
              label: 'Provisioned Capacity')
        ],
      )));
    } on ApiException catch (e) {
      debugPrint(e.message);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override 
  void before() => dispatch(WaitAction.add("load_db_write"));

  @override 
  void after() => dispatch(WaitAction.remove("load_db_write"));
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
