import 'package:flutter/material.dart';

@immutable
class AdvertModel {
  final String id;
  final String title;
  final String? description;
  final String? type;
  final String? acceptedBid;
  final String location;
  final String dateCreated;
  final String? dateClosed;

  const AdvertModel({
    required this.id,
    required this.title,
    this.description,
    this.type,
    this.acceptedBid,
    required this.location,
    required this.dateCreated,
    this.dateClosed,
  });

  factory AdvertModel.fromJson(obj) {
    return AdvertModel(
      id: obj['id'],
      title: obj['title'],
      description: obj['description'],
      type: obj['type'],
      acceptedBid: obj['accepted_bid'],
      location: obj['location'],
      dateCreated: obj['date_created'],
      dateClosed: obj['date_closed'],
    );
  }

  @override
  operator ==(Object other) =>
      other is AdvertModel &&
      id == other.id &&
      title == other.title &&
      description == other.description &&
      type == other.type &&
      acceptedBid == other.acceptedBid &&
      location == other.location &&
      dateCreated == other.dateCreated &&
      dateClosed == other.dateCreated;

  @override
  int get hashCode => hashValues(
        id,
        title,
        description,
        type,
        acceptedBid,
        location,
        dateCreated,
        dateClosed,
      );
}
