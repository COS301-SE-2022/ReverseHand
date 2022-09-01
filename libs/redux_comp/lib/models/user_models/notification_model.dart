import 'package:flutter/material.dart';

@immutable
class NotificationModel {
  final String title;
  final String msg;
  final String type;
  final double timestamp;

  const NotificationModel({
    required this.title,
    required this.msg,
    required this.type,
    required this.timestamp,
  });

  factory NotificationModel.fromJson(obj) {
    return NotificationModel(
      title: obj['title'],
      msg: obj['msg'],
      type: obj['type'],
      timestamp: obj['timestamp'].toDouble(),
    );
  }
}
