import 'package:flutter/material.dart';

import 'job_type.dart';

@immutable
class AdvertModel {
  final String id;
  final String userId;
  final String? description;
  final JobType? type;
  final List<String> bids;
  final List<String> shortlistedBid;
  final String? acceptedBid;
  final String? location;
  final String dateCreated;
  final String? dateClosed;

  const AdvertModel({
    required this.id,
    required this.userId,
    this.description,
    this.type,
    required this.bids,
    required this.shortlistedBid,
    this.acceptedBid,
    this.location,
    required this.dateCreated,
    this.dateClosed,
  });

  factory AdvertModel.fromJson(obj) {
    return AdvertModel(
      id: obj['id'],
      userId: obj['user_id'],
      description: obj['description'],
      type: obj,
      bids: obj['bids'],
      shortlistedBid: obj['shortlisted_bids'],
      acceptedBid: obj['accepted_bid'],
      location: obj['location'],
      dateCreated: obj['date_created'],
      dateClosed: obj['date_closed'],
    );
  }
}
