import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/admin/helper_functions/build_dimensions_query.dart';
import 'package:redux_comp/actions/admin/helper_functions/build_pie_data.dart';
import 'package:redux_comp/actions/admin/user_metrics/list_metrics_action.dart';
import 'package:redux_comp/models/admin/user_metrics/chart_model.dart';
import 'package:redux_comp/models/admin/user_metrics/dimensions_model.dart';
import 'package:redux_comp/models/admin/user_metrics/pie_chart_model.dart';

import '../../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class GetPlaceBidMetricsAction extends ReduxAction<AppState> {
  final DateTime time;

  GetPlaceBidMetricsAction(this.time);

  @override
  Future<AppState?> reduce() async {
    await dispatch(
        ListMetricsAction(metric: "PlaceBid", dimensionNames: ["Job_Type"]));
    DateTime start = time;
    DateTime end = start.add(const Duration(hours: 24));
    debugPrint("${end.toIso8601String()}Z ${start.toIso8601String()}Z");

    List<DimensionsModel> dimensions = state.admin.userMetrics.dimensions?["Job_Type"] ?? [];
    List<dynamic> queries = buildDimensionsQuery(dimensions, "PlaceBid");

    var params = {
      "EndTime": "${end.toIso8601String()}Z",
      "MetricDataQueries": queries,
      "StartTime": "${start.toIso8601String()}Z",
      "LabelOptions": {
        "Timezone": "+0200",
      },
      "ScanBy": "TimestampAscending"
    };

    String paramsJson = jsonEncode(params).replaceAll('"', '\\"');

    String graphQLDoc = '''query {
      getMetrics(params: "$paramsJson")
    }
    ''';

    final request = GraphQLRequest(document: graphQLDoc);
    try {
      final response = await Amplify.API.query(request: request).response;
      final data = jsonDecode(jsonDecode(
          response.data)["getMetrics"]); //resp is a json encoded json string
      final List<dynamic> values = data;

      List<PieChartModel> bidsPlacedByType = [];
      int color = 0;
      for (var data in values) {
        bidsPlacedByType.add(buildPieData(data, color++));
      }

      Map<String, List<PieChartModel>> graphs =
          state.admin.userMetrics.placeBidMetrics?.graphs ?? {};
      graphs.addEntries(
        [
          MapEntry(
            "bidsByType", //key
            bidsPlacedByType,
          ),
        ],
      );

      return state.copy(
        admin: state.admin.copy(
          userMetrics: state.admin.userMetrics.copy(
            placeBidMetrics: state.admin.userMetrics.placeBidMetrics?.copy(
                  graphs: graphs,
                ) ??
                ChartModel(
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

   @override
  void before() => dispatch(WaitAction.add("bid_type_metrics"));

  @override
  void after() => dispatch(WaitAction.remove("bid_type_metrics"));
}
// "{\"EndTime\":\"2022-09-27T10:38:17.845107Z\",\"MetricDataQueries\":[{\"Id\":\"placeBidPlumbing\",\"MetricStat\":{\"Metric\":{\"Dimensions\":[{\"Name\":\"Job_Type\",\"Value\":\"Plumbing\"}],\"MetricName\":\"PlaceBid\",\"Namespace\":\"CustomEvents\"},\"Period\":\"60\",\"Stat\":\"Sum\"},\"ReturnData\":true},{\"Id\":\"placeBidPlumbing\",\"MetricStat\":{\"Metric\":{\"Dimensions\":[{\"Name\":\"Job_Type\",\"Value\":\"Plumbing\"}],\"MetricName\":\"PlaceBid\",\"Namespace\":\"CustomEvents\"},\"Period\":\"60\",\"Stat\":\"Sum\"},\"ReturnData\":true},{\"Id\":\"placeBidPainting\",\"MetricStat\":{\"Metric\":{\"Dimensions\":[{\"Name\":\"Job_Type\",\"Value\":\"Painting\"}],\"MetricName\":\"PlaceBid\",\"Namespace\":\"CustomEvents\"},\"Period\":\"60\",\"Stat\":\"Sum\"},\"ReturnData\":true},{\"Id\":\"placeBidPainting\",\"MetricStat\":{\"Metric\":{\"Dimensions\":[{\"Name\":\"Job_Type\",\"Value\":\"Painting\"}],\"MetricName\":\"PlaceBid\",\"Namespace\":\"CustomEvents\"},\"Period\":\"60\",\"Stat\":\"Sum\"},\"ReturnData\":true}],\"StartTime\":\"2022-09-27T07:38:17.845107Z\",\"LabelOptions\":{\"Timezone\":\"+0200\"},\"ScanBy\":\"TimestampAscending\"}"