import 'package:flutter/material.dart';

@immutable
class NotificationModel {
  final String title;
  final String msg;
  final double timestamp;
  final String type;
  /*
    Possible Options for type are:
      - BidShortlisted
  */

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
