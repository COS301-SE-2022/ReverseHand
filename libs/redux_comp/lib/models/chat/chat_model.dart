import 'package:flutter/widgets.dart';

@immutable
class ChatModel {
  final String id;
  final String consumerName;
  final String tradesmanName;
  final String otherUserId;
  final double timestamp;

  const ChatModel({
    required this.id,
    required this.otherUserId,
    required this.tradesmanName,
    required this.consumerName,
    required this.timestamp,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json['id'],
        otherUserId: json['other_user_id'],
        timestamp: json['timestamp'].toDouble(),
        consumerName: json['consumer_name'],
        tradesmanName: json['tradesman_name'],
      );
}
