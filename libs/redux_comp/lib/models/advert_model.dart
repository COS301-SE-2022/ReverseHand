import 'package:flutter/material.dart';
import 'job_type.dart';

@immutable
class AdvertModel {
  final String id;
  final String title;
  final String userId;
  final String? description;
  final JobType? type;
  final String? acceptedBid;
  final String? location;
  final String dateCreated;
  final String? dateClosed;

  const AdvertModel({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    this.type,
    this.acceptedBid,
    this.location,
    required this.dateCreated,
    this.dateClosed,
  });

  factory AdvertModel.fromJson(obj) {
    return AdvertModel(
      id: obj['id'],
      userId: obj['user_id'],
      title: obj['title'],
      description: obj['description'],
      type: obj,
      acceptedBid: obj['accepted_bid'],
      location: obj['location'],
      dateCreated: obj['date_created'],
      dateClosed: obj['date_closed'],
    );
  }
}
