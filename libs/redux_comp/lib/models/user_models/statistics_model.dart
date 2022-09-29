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
      finished: obj['finished'],
    );
  }

  @override
  int get hashCode => Object.hash(ratingSum, ratingCount, created, finished);

  @override
  bool operator ==(Object other) {
    return other is StatisticsModel &&
        finished == other.finished &&
        ratingCount == other.ratingCount &&
        created == other.created &&
        ratingSum == other.ratingSum;
  }
}
