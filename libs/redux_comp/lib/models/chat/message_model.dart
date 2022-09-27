import 'package:flutter/widgets.dart';

@immutable
class MessageModel {
  final String id;
  final String chatId;
  final String msg;
  final String sender;
  final double timestamp;
  final double sentiment;

  const MessageModel({
    required this.id,
    required this.chatId,
    required this.msg,
    required this.sender,
    required this.timestamp,
    required this.sentiment,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json['id'],
        chatId: json['chat_id'],
        msg: json['msg'],
        sender: json['sender'],
        timestamp: json['timestamp'].toDouble(),
        sentiment: json['sentiment'].toDouble(),
      );

  @override
  operator ==(Object other) =>
      other is MessageModel &&
      id == other.id &&
      chatId == other.chatId &&
      msg == other.msg &&
      sender == other.sender &&
      timestamp == other.timestamp;

  @override
  int get hashCode => Object.hash(
        id,
        chatId,
        msg,
        sender,
        timestamp,
      );
}
