import 'package:flutter/material.dart';
import 'package:redux_comp/models/user_models/tradesman_stats_model.dart';

import 'consumer_stats_model.dart';

@immutable
class StatisticsModel {
  final int ratingSum;
  final int numReviews;

  final ConsumerStatsModel? consumerStats;
  final TradesmanStatsModel? tradesManStats;

  const StatisticsModel(
      {required this.ratingSum,
      required this.numReviews,
      required this.consumerStats,
      required this.tradesManStats});

  factory StatisticsModel.fromJson(obj) {
    return StatisticsModel(
        ratingSum: obj['rating_sum'],
        numReviews: obj['num_reviews'],
        consumerStats: obj['consumer_stats'],
        tradesManStats: obj['tradesman_stats']);
  }
}
