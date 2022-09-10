import 'package:flutter/material.dart';

@immutable
class StatisticsModel {
  final int ratingSum;
  final int ratingCount;

  final int created; // adverts with a successful bid and number of bids one
  final int finished; // number of adverts/bids created

  const StatisticsModel({
    required this.ratingSum,
    required this.ratingCount,
    required this.created,
    required this.finished,
  });

  factory StatisticsModel.fromJson(obj) {
    return StatisticsModel(
        ratingSum: obj['rating_sum'],
        ratingCount: obj['rating_count'],
        created: obj['created'],
        finished: obj['finished']);
  }
}
