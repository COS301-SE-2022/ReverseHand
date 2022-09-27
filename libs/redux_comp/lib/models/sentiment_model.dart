import 'package:flutter/material.dart';

@immutable
class SentimentModel {
  final int positiveMessages;
  final int negativeMessages;
  final int neutralMessages;
  final double positive;
  final double negative;

  const SentimentModel({
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

  String resultString() {
    final double val = positive + negative;
    if (val > 0) {
      return 'Positive';
    } else if (val < 0) {
      return 'Negative';
    } else {
      return 'Neutral';
    }
  }

  IconData resultIcon() {
    final double val = positive + negative;
    if (val > 0) {
      return Icons.sentiment_very_satisfied;
    } else if (val < 0) {
      return Icons.sentiment_very_dissatisfied;
    } else {
      return Icons.sentiment_neutral;
    }
  }

  MaterialColor resultColor() {
    final double val = positive + negative;
    if (val > 0) {
      return Colors.green;
    } else if (val < 0) {
      return Colors.red;
    } else {
      return Colors.orange;
    }
  }

  factory SentimentModel.fromJson(Map<String, dynamic> obj) {
    return SentimentModel(
      positiveMessages: obj['positive_messages'],
      negativeMessages: obj['negative_messages'],
      neutralMessages: obj['neutral_messages'],
      positive: obj['positive'].toDouble(),
      negative: obj['negative'].toDouble(),
    );
  }
}
