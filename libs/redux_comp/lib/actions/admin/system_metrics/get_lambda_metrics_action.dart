import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/admin/system_metrics/build_data.dart';
import 'package:redux_comp/models/admin/app_metrics/line_chart_model.dart';

import '../../../app_state.dart';
import 'package:async_redux/async_redux.dart';

import '../../../models/admin/app_metrics/metrics_model.dart';

class GetLambdaMetricsAction extends ReduxAction<AppState> {
  final int hoursAgo;
  final int period;
  GetLambdaMetricsAction({required this.hoursAgo, required this.period});

  @override
  Future<AppState?> reduce() async {
    DateTime end = DateTime.now().subtract(const Duration(hours: 2));
    DateTime start = end.subtract(Duration(hours: hoursAgo));
    int paramsPeriod = period * 60;

    var params = {
      "EndTime": "${end.toIso8601String()}Z",
      /* required */
      "MetricDataQueries": [
        {
          "Id": 'getMetricsResolver',
          "Label": 'Invocations',
          "MetricStat": {
            "Metric": {
              "Dimensions": [
                {
                  "Name": 'FunctionName',
                  "Value": "getMetricsResolver-staging",
                }
              ],
              "MetricName": 'Invocations',
              "Namespace": 'AWS/Lambda'
            },
            "Period": paramsPeriod, // day
            "Stat": 'Sum',
            "Unit": 'Count',
          },
        },
        {
          "Id": 'removeReviewReportResolver',
          "Label": 'Invocations',
          "MetricStat": {
            "Metric": {
              "Dimensions": [
                {
                  "Name": 'FunctionName',
                  "Value": "removeReviewReportResolver-staging",
                }
              ],
              "MetricName": 'Invocations',
              "Namespace": 'AWS/Lambda'
            },
            "Period": paramsPeriod, // day
            "Stat": 'Sum',
            "Unit": 'Count',
          },
        },
        {
          "Id": 'addReviewReportResolver',
          "Label": 'Invocations',
          "MetricStat": {
            "Metric": {
              "Dimensions": [
                {
                  "Name": 'FunctionName',
                  "Value": "addReviewReportResolver-staging",
                }
              ],
              "MetricName": 'Invocations',
              "Namespace": 'AWS/Lambda'
            },
            "Period": paramsPeriod, // day
            "Stat": 'Sum',
            "Unit": 'Count',
          },
        },
        {
          "Id": 'addUserReportResolver',
          "Label": 'Invocations',
          "MetricStat": {
            "Metric": {
              "Dimensions": [
                {
                  "Name": 'FunctionName',
                  "Value": "addUserReportResolver-staging",
                }
              ],
              "MetricName": 'Invocations',
              "Namespace": 'AWS/Lambda'
            },
            "Period": paramsPeriod, // day
            "Stat": 'Sum',
            "Unit": 'Count',
          },
        },
        {
          "Id": 'addAdvertReportResolver',
          "Label": 'Invocations',
          "MetricStat": {
            "Metric": {
              "Dimensions": [
                {
                  "Name": 'FunctionName',
                  "Value": "addAdvertReportResolver-staging",
                }
              ],
              "MetricName": 'Invocations',
              "Namespace": 'AWS/Lambda'
            },
            "Period": paramsPeriod, // day
            "Stat": 'Sum',
            "Unit": 'Count',
          },
        },
        {
          "Id": 'removeUserReportResolver',
          "Label": 'Invocations',
          "MetricStat": {
            "Metric": {
              "Dimensions": [
                {
                  "Name": 'FunctionName',
                  "Value": "removeUserReportResolver-staging",
                }
              ],
              "MetricName": 'Invocations',
              "Namespace": 'AWS/Lambda'
            },
            "Period": paramsPeriod, // day
            "Stat": 'Sum',
            "Unit": 'Count',
          },
        },
        {
          "Id": 'acceptAdvertReportResolver',
          "Label": 'Invocations',
          "MetricStat": {
            "Metric": {
              "Dimensions": [
                {
                  "Name": 'FunctionName',
                  "Value": "acceptAdvertReportResolver-staging",
                }
              ],
              "MetricName": 'Invocations',
              "Namespace": 'AWS/Lambda'
            },
            "Period": paramsPeriod, // day
            "Stat": 'Sum',
            "Unit": 'Count',
          },
        },
        {
          "Id": 'getReportsResolver',
          "Label": 'Invocations',
          "MetricStat": {
            "Metric": {
              "Dimensions": [
                {
                  "Name": 'FunctionName',
                  "Value": "getReportsResolver-staging",
                }
              ],
              "MetricName": 'Invocations',
              "Namespace": 'AWS/Lambda'
            },
            "Period": paramsPeriod, // day
            "Stat": 'Sum',
            "Unit": 'Count',
          },
        },
        {
          "Id": 'getReportedAdvertsResolver',
          "Label": 'Invocations',
          "MetricStat": {
            "Metric": {
              "Dimensions": [
                {
                  "Name": 'FunctionName',
                  "Value": "getReportedAdvertsResolver-staging",
                }
              ],
              "MetricName": 'Invocations',
              "Namespace": 'AWS/Lambda'
            },
            "Period": paramsPeriod, // day
            "Stat": 'Sum',
            "Unit": 'Count',
          },
        },
        {
          "Id": 'adminGetUserResolver',
          "Label": 'Invocations',
          "MetricStat": {
            "Metric": {
              "Dimensions": [
                {
                  "Name": 'FunctionName',
                  "Value": "adminGetUserResolver-staging",
                }
              ],
              "MetricName": 'Invocations',
              "Namespace": 'AWS/Lambda'
            },
            "Period": paramsPeriod, // day
            "Stat": 'Sum',
            "Unit": 'Count',
          },
        },
        {
          "Id": 'adminSearchUserResolver',
          "Label": 'Invocations',
          "MetricStat": {
            "Metric": {
              "Dimensions": [
                {
                  "Name": 'FunctionName',
                  "Value": "adminSearchUserResolver-staging",
                }
              ],
              "MetricName": 'Invocations',
              "Namespace": 'AWS/Lambda'
            },
            "Period": paramsPeriod, // day
            "Stat": 'Sum',
            "Unit": 'Count',
          },
        },
        {
          "Id": 'listUsersResolver',
          "Label": 'Invocations',
          "MetricStat": {
            "Metric": {
              "Dimensions": [
                {
                  "Name": 'FunctionName',
                  "Value": "listUsersResolver-staging",
                }
              ],
              "MetricName": 'Invocations',
              "Namespace": 'AWS/Lambda'
            },
            "Period": paramsPeriod, // day
            "Stat": 'Sum',
            "Unit": 'Count',
          },
        },
        {
          "Id": 'processKinesisStreamResolver',
          "Label": 'Invocations',
          "MetricStat": {
            "Metric": {
              "Dimensions": [
                {
                  "Name": 'FunctionName',
                  "Value": "processKinesisStreamResolver-staging",
                }
              ],
              "MetricName": 'Invocations',
              "Namespace": 'AWS/Lambda'
            },
            "Period": paramsPeriod, // day
            "Stat": 'Sum',
            "Unit": 'Count',
          },
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
      List<LineChartModel> adminResolvers = [];

      for (var data in values) {
        adminResolvers.add(
          LineChartModel(
            label: data["Id"],
            data: buildData(data, start, end, period),
          ),
        );
      }

      Map<String, List<LineChartModel>> graphs =
          state.admin.appMetrics.adminResolvers?.graphs ?? {};
      graphs.addEntries(
        [
          MapEntry(
            "adminData", //key
            adminResolvers,
          )
        ],
      );
      return state.copy(
        admin: state.admin.copy(
          appMetrics: state.admin.appMetrics.copy(
            adminResolvers: state.admin.appMetrics.adminResolvers?.copy(
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
}


// [ "AWS/Lambda", "Invocations", "FunctionName", "removeReviewReportResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "addReviewReportResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "addUserReportResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "addAdvertReportResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "removeUserReportResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "acceptAdvertReportResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "getReportsResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "getReportedAdvertsResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "adminGetUserResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "adminSearchUserResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "listUsersResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "processKinesisStreamResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "getMetricsResolver-staging", { "period": 300, "stat": "Sum" } ],

// [ "AWS/Lambda", "Invocations", "FunctionName", "getChatsResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "createChatResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "deleteChatResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "getMessagesResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "sendMessageResolver-staging", { "period": 300, "stat": "Sum" } ],

// [ "AWS/Lambda", "Invocations", "FunctionName", "acceptBidResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "shortListBidResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "getBidOnAdvertsResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "viewBidsResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "deleteBidResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "placeBidResolver-staging", { "period": 300, "stat": "Sum" } ],


// [ "AWS/Lambda", "Invocations", "FunctionName", "addReviewResolver-staging", { "period": 300, "stat": "Sum" } ],

// [ "AWS/Lambda", "Invocations", "FunctionName", "createUserResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "viewUserResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "editUserDetailResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "getUserReviewsResolver-staging", { "period": 300, "stat": "Sum" } ],


// [ "AWS/Lambda", "Invocations", "FunctionName", "viewJobsResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "viewAdvertsResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "createAdvertResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "archiveAdvertResolver-staging", { "period": 300, "stat": "Sum" } ],

// [ "AWS/Lambda", "Invocations", "FunctionName", "notifyNewNotificationsResolver-staging", { "period": 300, "stat": "Sum" } ],
// [ "AWS/Lambda", "Invocations", "FunctionName", "getNotificationsResolver-staging", { "period": 300, "stat": "Sum" } ],
