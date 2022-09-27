import 'package:flutter/material.dart';

@immutable
class SentimentModel {
  final String id;
  final int positiveMessages;
  final int negativeMessages;
  final int neutralMessages;
  final double positive;
  final double negative;

  const SentimentModel({
    required this.id,
    required this.positiveMessages,
    required this.negativeMessages,
    required this.neutralMessages,
    required this.positive,
    required this.negative,
  });

  double overallSentiment() {
    return (positive + negative) /
        (positiveMessages + negativeMessages + neutralMessages);
  }

  int totalMessages() {
    return positiveMessages + negativeMessages + neutralMessages;
  }

  factory SentimentModel.fromJson(Map<String, dynamic> obj) {
    return SentimentModel(
      id: obj['id'],
      positiveMessages: obj['positive_messages'],
      negativeMessages: obj['negative_messages'],
      neutralMessages: obj['neutral_messages'],
      positive: obj['positive'].toDouble(),
      negative: obj['negative'].toDouble(),
    );
  }
}
