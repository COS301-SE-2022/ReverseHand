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
        // {
        //   "Id": 'getReportedUsersResolver',
        //   /* required */
        //   "MetricStat": {
        //     "Metric": {
        //       /* required */
        //       "Dimensions": [
        //         {
        //           "Name": 'FunctionName',
        //           /* required */
        //           "Value": 'getReportedUsersResolver-staging' /* required */
        //         },
        //         /* more items */
        //       ],
        //       "MetricName": 'Invocations',
        //       "Namespace": 'AWS/Lambda'
        //     },
        //     "Period": '$paramsPeriod',
        //     /* required */
        //     "Stat": 'Sum', /* required */
        //   },
        // }
//         },
        // {
        //   "Id": "m1",
        //   "Label": "Unhealthy Behind Load Balancer",
        //   "MetricStat": {
        //     "Metric": {
        //       "Namespace": "AWS/Lambda",
        //       "MetricName": "Invocations",
        //       "Dimensions": [
        //         {
        //           "Name": "FunctionName",
        //           "Value": "adminSearchUserResolver-staging"
        //         }
        //       ]
        //     },
        //     "Period": 300,
        //     "Stat": "Average"
        //   }
        // }
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
// {"AWS/Lambda", "Invocations", "FunctionName", "adminGetUserResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "adminSearchUserResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "listUsersResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "acceptAdvertReportResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "removeUserReportResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "getReportedAdvertsResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "addUserReportResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "addReviewReportResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "getReportedUsersResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "getReportsResolver-staging", { "period": 300, "stat": "Sum" } ],

// {"AWS/Lambda", "Invocations", "FunctionName", "notificationsResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "addReviewResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "getBidOnAdvertsResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "archiveAdvertResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "acceptBidResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "getUserReviewsResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "shortListBidResolver-staging", { "period": 300, "stat": "Sum" } ],

// {"AWS/Lambda", "Invocations", "FunctionName", "viewUserResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "getMessagesResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "getNotificationsResolver-staging", { "period": 300, "stat": "Sum" } ],

// {"AWS/Lambda", "Invocations", "FunctionName", "viewAdvertsResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "viewJobsResolver-staging", { "period": 300, "stat": "Sum" } ],

// {"AWS/Lambda", "Invocations", "FunctionName", "viewBidsResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "placeBidResolver-staging", { "period": 300, "stat": "Sum" } ],

// {"AWS/Lambda", "Invocations", "FunctionName", "createAdvertResolver-staging", { "period": 300, "stat": "Sum" } ],
// {"AWS/Lambda", "Invocations", "FunctionName", "addAdvertReportResolver-staging", { "period": 300, "stat": "Sum" } ],



// {
//           "Id": 'adminSearchUserResolver',
//           /* required */
//           "MetricStat": {
//             "Metric": {
//               /* required */
//               "Dimensions": [
//                 {
//                   "Name": 'FunctionName',
//                   /* required */
//                   "Value": 'adminSearchUserResolver-staging' /* required */
//                 },
//                 /* more items */
//               ],
//               "MetricName": 'Invocations',
//               "Namespace": 'AWS/Lambda'
//             },
//             "Period": '$paramsPeriod',
//             /* required */
//             "Stat": 'Sum', /* required */
//           },
//           "ReturnData": true
//         },
//         {
//           "Id": 'listUsersResolver',
//           /* required */
//           "MetricStat": {
//             "Metric": {
//               /* required */
//               "Dimensions": [
//                 {
//                   "Name": 'FunctionName',
//                   /* required */
//                   "Value": 'listUsersResolver-staging' /* required */
//                 },
//                 /* more items */
//               ],
//               "MetricName": 'Invocations',
//               "Namespace": 'AWS/Lambda'
//             },
//             "Period": '$paramsPeriod',
//             /* required */
//             "Stat": 'Sum', /* required */
//           },
//           "ReturnData": true
//         },
//         {
//           "Id": 'acceptAdvertReportResolver',
//           /* required */
//           "MetricStat": {
//             "Metric": {
//               /* required */
//               "Dimensions": [
//                 {
//                   "Name": 'FunctionName',
//                   /* required */
//                   "Value": 'acceptAdvertReportResolver-staging' /* required */
//                 },
//                 /* more items */
//               ],
//               "MetricName": 'Invocations',
//               "Namespace": 'AWS/Lambda'
//             },
//             "Period": '$paramsPeriod',
//             /* required */
//             "Stat": 'Average', /* required */
//           },
//           "ReturnData": true
//         },
//         {
//           "Id": 'removeUserReportResolver',
//           /* required */
//           "MetricStat": {
//             "Metric": {
//               /* required */
//               "Dimensions": [
//                 {
//                   "Name": 'FunctionName',
//                   /* required */
//                   "Value": 'removeUserReportResolver-staging' /* required */
//                 },
//                 /* more items */
//               ],
//               "MetricName": 'Invocations',
//               "Namespace": 'AWS/Lambda'
//             },
//             "Period": '$paramsPeriod',
//             /* required */
//             "Stat": 'Sum', /* required */
//           },
//           "ReturnData": true
//         },
//         {
//           "Id": 'getReportedAdvertsResolver',
//           /* required */
//           "MetricStat": {
//             "Metric": {
//               /* required */
//               "Dimensions": [
//                 {
//                   "Name": 'FunctionName',
//                   /* required */
//                   "Value": 'getReportedAdvertsResolver-staging' /* required */
//                 },
//                 /* more items */
//               ],
//               "MetricName": 'Invocations',
//               "Namespace": 'AWS/Lambda'
//             },
//             "Period": '$paramsPeriod',
//             /* required */
//             "Stat": 'Sum', /* required */
//           },
//           "ReturnData": true
//         },
//         {
//           "Id": 'addUserReportResolver',
//           /* required */
//           "MetricStat": {
//             "Metric": {
//               /* required */
//               "Dimensions": [
//                 {
//                   "Name": 'FunctionName',
//                   /* required */
//                   "Value": 'addUserReportResolver-staging' /* required */
//                 },
//                 /* more items */
//               ],
//               "MetricName": 'Invocations',
//               "Namespace": 'AWS/Lambda'
//             },
//             "Period": '$paramsPeriod',
//             /* required */
//             "Stat": 'Sum', /* required */
//           },
//           "ReturnData": true
//         },
//         {
//           "Id": 'addReviewReportResolver',
//           /* required */
//           "MetricStat": {
//             "Metric": {
//               /* required */
//               "Dimensions": [
//                 {
//                   "Name": 'FunctionName',
//                   /* required */
//                   "Value": 'addReviewReportResolver-staging' /* required */
//                 },
//                 /* more items */
//               ],
//               "MetricName": 'Invocations',
//               "Namespace": 'AWS/Lambda'
//             },
//             "Period": '$paramsPeriod',
//             /* required */
//             "Stat": 'Sum', /* required */
//           },
//           "ReturnData": true
//         },

//         {
//           "Id": 'getReportsResolver',
//           /* required */
//           "MetricStat": {
//             "Metric": {
//               /* required */
//               "Dimensions": [
//                 {
//                   "Name": 'FunctionName',
//                   /* required */
//                   "Value": 'getReportsResolver-staging' /* required */
//                 },
//                 /* more items */
//               ],
//               "MetricName": 'Invocations',
//               "Namespace": 'AWS/Lambda'
//             },
//             "Period": '$paramsPeriod',
//             /* required */
//             "Stat": 'Sum', /* required */
//           },
//           "ReturnData": true
//         }





