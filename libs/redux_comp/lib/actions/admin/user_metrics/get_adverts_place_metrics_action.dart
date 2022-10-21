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

class GetAdvertPlaceMetrics extends ReduxAction<AppState> {
  final DateTime time;

  GetAdvertPlaceMetrics(this.time);

  @override
  Future<AppState?> reduce() async {
    await dispatch(
        ListMetricsAction(metric: "CreateAdvert", dimensionNames: ["City"]));
    DateTime start = time;
    DateTime end = start.add(const Duration(hours: 24));

    List<DimensionsModel> dimensions =
        state.admin.userMetrics.dimensions?["City"] ?? [];
    List<dynamic> queries = buildDimensionsQuery(dimensions, "CreateAdvert");

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

      List<PieChartModel> advertsPlacedByCity = [];
      int color = 0;
      for (var data in values) {
        if (data["Values"].length != 0 ) {
          advertsPlacedByCity.add(buildPieData(data, color++));
        }
      }

      Map<String, List<PieChartModel>> graphs =
          state.admin.userMetrics.createAdvertMetrics?.graphs ?? {};
      graphs.addEntries(
        [
          MapEntry(
            "advertsByCity", //key
            advertsPlacedByCity,
          ),
        ],
      );

      return state.copy(
        admin: state.admin.copy(
          userMetrics: state.admin.userMetrics.copy(
            createAdvertMetrics:
                state.admin.userMetrics.createAdvertMetrics?.copy(
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
  void before() => dispatch(WaitAction.add("advert_place_metrics"));

  @override
  void after() => dispatch(WaitAction.remove("advert_place_metrics"));
}
