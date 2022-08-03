import 'package:flutter/widgets.dart';

@immutable
class NotificationModel {
  final String title;
  final String msg;
  final NotificationType type;
  final double timestamp;

  const NotificationModel({
    required this.title,
    required this.msg,
    required this.type,
    required this.timestamp,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        title: json['title'],
        msg: json['msg'],
        type: json['type'],
        timestamp: json['timestamp'].toDouble(),
      );
}

enum NotificationType {
  bidShortlisted,
  bidAccepted,
  bidPlaced,
  jobPosted,
}

// NotificationType stringToNotificationType(String type) {}
