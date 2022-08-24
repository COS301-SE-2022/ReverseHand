import 'package:flutter/widgets.dart';

@immutable
class MessageModel {
  final String msg;
  final String sender;
  final String name;
  final double timestamp;

  const MessageModel({
    required this.msg,
    required this.name,
    required this.sender,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        msg: json['msg'],
        sender: json['sender'],
        timestamp: json['timestamp'].toDouble(),
        name: json['name'],
      );
}
