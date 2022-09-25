import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/admin/system_metrics/build_lambda_metric_query.dart';
import 'package:redux_comp/models/admin/app_metrics/metrics_model.dart';
import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../../../models/admin/app_metrics/line_chart_model.dart';
import 'build_data.dart';

class GetResolverErrorsAction extends ReduxAction<AppState> {
  final int hoursAgo;
  final int period;
  GetResolverErrorsAction({required this.hoursAgo, required this.period});

  @override
  Future<AppState?> reduce() async {
    DateTime end = DateTime.now().subtract(const Duration(hours: 2));
    DateTime start = end.subtract(Duration(hours: hoursAgo));
    int paramsPeriod = period * 60;

    List<String> adminFunctions = [
      "getMetricsResolver",
      "removeReviewReportResolver",
      "addReviewReportResolver",
      "addUserReportResolver",
      "addAdvertReportResolver",
      "removeUserReportResolver",
      "acceptAdvertReportResolver",
      "getReportsResolver",
      "getReportedAdvertsResolver",
      "adminGetUserResolver",
      "adminSearchUserResolver",
      "listUsersResolver",
      "processKinesisStreamResolver",
    ];
    List<String> userFunctions = [
      "createUserResolver",
      "viewUserResolver",
      "editUserDetailResolver",
      "getUserReviewsResolver",
    ];

    List<Map> querys = [];

    for (String function in adminFunctions) {
      querys.add(buildLambdaMetricQuery(
          function, "Errors", "adminErrors", paramsPeriod));
    }
    for (String function in userFunctions) {
      querys.add(buildLambdaMetricQuery(
          function, "Errors", "userErrors", paramsPeriod));
    }

    var params = {
      "EndTime": "${end.toIso8601String()}Z",
      /* required */
      "MetricDataQueries": querys,
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
      List<LineChartModel> userErrorResolvers = [];
      List<LineChartModel> adminErrorResolvers = [];

      for (var data in values) {
        switch (data["Label"]) {
          case "userErrors":
            userErrorResolvers.add(
              LineChartModel(
                label: data["Id"],
                data: buildData(data, start, end, period),
              ),
            );
            break;
          case "adminErrors":
            adminErrorResolvers.add(
              LineChartModel(
                label: data["Id"],
                data: buildData(data, start, end, period),
              ),
            );
            break;
        }
      }

      Map<String, List<LineChartModel>> graphs =
          state.admin.appMetrics.adminResolvers?.graphs ?? {};
      graphs.addEntries(
        [
          MapEntry(
            "userErrorData", //key
            userErrorResolvers,
          ),
          MapEntry(
            "adminErrorData", //key
            adminErrorResolvers,
          ),
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
