import 'package:flutter/material.dart';

@immutable
class ConsumerStatsModel {
  final int numAdvertsWon; //num jobs successfully completed by tradesman
  final int numAdvertsCreated;

  const ConsumerStatsModel(
      {required this.numAdvertsWon, required this.numAdvertsCreated});

  ConsumerStatsModel copy({int? numAdvertsWon, int? numAdvertsCreated}) {
    return ConsumerStatsModel(
        numAdvertsWon: numAdvertsWon ?? this.numAdvertsWon,
        numAdvertsCreated: numAdvertsCreated ?? this.numAdvertsCreated);
  }

  factory ConsumerStatsModel.fromJson(obj) {
    return ConsumerStatsModel(
        numAdvertsWon: obj['num_adverts_won'],
        numAdvertsCreated: obj['num_adverts_created']);
  }
}
