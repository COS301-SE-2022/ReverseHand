import 'package:flutter/material.dart';
import 'package:redux_comp/models/user_models/tradesman_stats_model.dart';

import 'consumer_stats_model.dart';

@immutable
class StatisticsModel {
  final int ratingSum;
  final int numReviews;

  final int numWon; // adverts with a successful bid and number of bids one
  final int numCreated; // number of adverts/bids created

  const StatisticsModel({
    required this.ratingSum,
    required this.numReviews,
    required this.numWon,
    required this.numCreated,
  });

  factory StatisticsModel.fromJson(obj) {
    return StatisticsModel(
        ratingSum: obj['rating_sum'],
        numReviews: obj['num_reviews'],
        numWon: obj['num_won'],
        numCreated: obj['num_created']);
  }
}
