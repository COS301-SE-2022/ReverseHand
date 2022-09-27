import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/user_metrics/dimensions_model.dart';

import '../../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class ListMetricsAction extends ReduxAction<AppState> {
  String metric;
  List<String> dimensionNames;
  ListMetricsAction({required this.metric, required this.dimensionNames});

  @override
  Future<AppState?> reduce() async {
    var names = [];
    for (var name in dimensionNames) {
      names.add({
        "Name": name,
      });
    }

    var params = {
      "Dimensions": names,
      "MetricName": metric.toString(),
      "Namespace": "CustomEvents",
    };

    String graphQLDoc = '''query {
      listMetrics(params: "${jsonEncode(params).replaceAll('"', '\\"')}")
    }
    ''';

    debugPrint(params.toString());

    final request = GraphQLRequest(document: graphQLDoc);
    try {
      final response = await Amplify.API.query(request: request).response;
      final data = jsonDecode(jsonDecode(
          response.data)["listMetrics"]); //resp is a json encoded json string
      if (response.errors.isEmpty) {
        List<dynamic> vals = data;
        List<DimensionsModel> dimensionModels = [];
        for (var dimension in vals) {
          if (dimension["Dimensions"].length == 1) {
            dimensionModels.add(DimensionsModel.fromJson(dimension));
          }
        }

        Map<String, List<DimensionsModel>> mapDimensions =
            state.admin.userMetrics.dimensions ?? {};

        for (var name in dimensionNames) {
          mapDimensions.addEntries([MapEntry(name, dimensionModels)]);
        }

        return state.copy(
          admin: state.admin.copy(
            userMetrics: state.admin.userMetrics.copy(
              dimensions: mapDimensions,
            ),
          ),
        );
      } else {
        debugPrint(response.errors.toString());
        return null;
      }
    } on ApiException catch (e) {
      debugPrint(e.message);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
