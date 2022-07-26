import 'dart:ffi';

import 'package:flutter/widgets.dart';

@immutable
class MessageModel {
  final String msg;
  final String sender;
  final int timestamp;

  const MessageModel({
    required this.msg,
    required this.sender,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        msg: json['msg'],
        sender: json['sender'],
        timestamp: json['timestamp'],
      );
}
