import 'package:flutter/widgets.dart';

@immutable
class MessageModel {
  final String id;
  final String chatId;
  final String msg;
  final String sender;
  final double timestamp;

  const MessageModel({
    required this.id,
    required this.chatId,
    required this.msg,
    required this.sender,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json['id'],
        chatId: json['chat_id'],
        msg: json['msg'],
        sender: json['sender'],
        timestamp: json['timestamp'].toDouble(),
      );
}
