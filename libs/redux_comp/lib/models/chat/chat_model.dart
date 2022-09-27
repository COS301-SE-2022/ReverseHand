import 'package:flutter/widgets.dart';
import 'package:redux_comp/models/sentiment_model.dart';

@immutable
class ChatModel {
  final String id;
  final String consumerName;
  final String tradesmanName;
  final String otherUserId;
  final double timestamp;
  final String? image;
  final SentimentModel? sentiment;

  const ChatModel({
    required this.id,
    required this.otherUserId,
    required this.tradesmanName,
    required this.consumerName,
    required this.timestamp,
    this.image,
    this.sentiment,
  });

  ChatModel copy({
    String? id,
    String? consumerName,
    String? tradesmanName,
    String? otherUserId,
    double? timestamp,
    String? image,
  }) {
    return ChatModel(
      id: id ?? this.id,
      otherUserId: otherUserId ?? this.otherUserId,
      tradesmanName: tradesmanName ?? this.tradesmanName,
      consumerName: consumerName ?? this.consumerName,
      timestamp: timestamp ?? this.timestamp,
      image: image ?? this.image,
    );
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json['id'],
        otherUserId: json['other_user_id'],
        timestamp: json['timestamp'].toDouble(),
        consumerName: json['consumer_name'],
        tradesmanName: json['tradesman_name'],
        sentiment: json['sentiment'] != null
            ? SentimentModel.fromJson(json['sentiment'])
            : null,
      );

  @override
  operator ==(Object other) =>
      other is ChatModel &&
      id == other.id &&
      consumerName == other.consumerName &&
      tradesmanName == other.tradesmanName &&
      otherUserId == other.otherUserId &&
      timestamp == other.timestamp &&
      image == other.image;

  @override
  int get hashCode => Object.hash(
        id,
        consumerName,
        tradesmanName,
        timestamp,
        otherUserId,
        image,
      );
}
