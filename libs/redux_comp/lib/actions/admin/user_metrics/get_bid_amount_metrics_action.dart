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

class GetBidAmountMetricsAction extends ReduxAction<AppState> {
  final DateTime time;

  GetBidAmountMetricsAction(this.time);

  @override
  Future<AppState?> reduce() async {
    await dispatch(
        ListMetricsAction(metric: "PlaceBid", dimensionNames: ["Amount"]));
    DateTime start = time;
    DateTime end = start.add(const Duration(hours: 24));

    List<DimensionsModel> dimensions = state.admin.userMetrics.dimensions?["Amount"] ?? [];
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
      for (var data in values) {
        bidsPlacedByType.add(buildPieData(data));
      }

      Map<String, List<PieChartModel>> graphs =
          state.admin.userMetrics.placeBidMetrics?.graphs ?? {};
      graphs.addEntries(
        [
          MapEntry(
            "bidsByAmount", //key
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
}