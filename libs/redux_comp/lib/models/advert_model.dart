import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';

@immutable
class AdvertModel {
  final String id;
  final String title;
  final String? description;
  final String? type;
  final String? acceptedBid;
  final Domain domain;
  final String dateCreated;
  final String? dateClosed;

  const AdvertModel({
    required this.id,
    required this.title,
    this.description,
    this.type,
    this.acceptedBid,
    required this.domain,
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
      domain: Domain.fromJson(obj['domain']),
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
      domain == other.domain &&
      dateCreated == other.dateCreated &&
      dateClosed == other.dateCreated;

  @override
  int get hashCode => hashValues(
        id,
        title,
        description,
        type,
        acceptedBid,
        domain,
        dateCreated,
        dateClosed,
      );
}
