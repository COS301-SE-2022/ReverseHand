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
          consumer_stats {
            num_adverts_won
            num_adverts_created
          }
          tradesman_stats {
            num_jobs_won
            num_bids_placed
          }
          rating_sum
          num_reviews
      }
    }''';

    final request = GraphQLRequest(document: graphQLDocument);

    try {
      final response = await Amplify.API.query(request: request).response;

      final data = jsonDecode(response.data);

      final ConsumerStatsModel consumerStats = ConsumerStatsModel(
          numAdvertsWon: data['getUserStatistics']['consumer_stats']
              ['num_adverts_won'],
          numAdvertsCreated: data['getUserStatistics']['consumer_stats']
              ['num_adverts_created']);

      final TradesmanStatsModel tradesManStats = TradesmanStatsModel(
          numJobsWon: data['getUserStatistics']['tradesman_stats']
              ['num_jobs_won'],
          numBidsPlaced: data['getUserStatistics']['tradesman_stats']
              ['num_bids_placed']);

      final StatisticsModel stats = StatisticsModel(
          ratingSum: data['getUserStatistics']['rating_sum'],
          numReviews: data['getUserStatistics']['num_reviews'],
          consumerStats: consumerStats,
          tradesManStats: tradesManStats);

      return state.copy(userStatistics: stats);
    } on ApiException catch (e) {
      debugPrint(e.message);
      return state.copy(error: ErrorType.failedToGetUserStatistics);
    }
  }
}
