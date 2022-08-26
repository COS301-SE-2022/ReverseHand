import 'package:flutter/material.dart';

@immutable
class TradesmanStatsModel {
  final int numJobsWon;
  final int numBidsPlaced;

  const TradesmanStatsModel(
      {required this.numJobsWon, required this.numBidsPlaced});

  TradesmanStatsModel copy({int? numJobsWon, int? numBidsPlaced}) {
    return TradesmanStatsModel(
        numJobsWon: numJobsWon ?? this.numJobsWon,
        numBidsPlaced: numBidsPlaced ?? this.numBidsPlaced);
  }

  factory TradesmanStatsModel.fromJson(obj) {
    return TradesmanStatsModel(
        numJobsWon: obj['num_jobs_won'], numBidsPlaced: obj['num_bids_placed']);
  }
}
