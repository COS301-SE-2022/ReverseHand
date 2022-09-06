import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/models/user_models/consumer_stats_model.dart';
import 'package:redux_comp/models/user_models/statistics_model.dart';
import 'package:redux_comp/models/user_models/tradesman_stats_model.dart';
import 'package:redux_comp/redux_comp.dart';

class GetUserStatisticsAction extends ReduxAction<AppState> {
  final String userId;

  GetUserStatisticsAction({required this.userId});

  @override
  Future<AppState?> reduce() async {
    String graphQLDocument = '''query {
      getUserStatistics(
        user_id : "$userId"
      ){
          num_created
          num_won
          rating_sum
          num_reviews
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.query(request: request).response;

      final data = jsonDecode(response.data);

      final StatisticsModel stats =
          StatisticsModel.fromJson(data['getUserStatistics']);

      return state.copy(userStatistics: stats);
    } on ApiException catch (e) {
      debugPrint(e.message);
      return state.copy(error: ErrorType.failedToGetUserStatistics);
    }
  }
}
