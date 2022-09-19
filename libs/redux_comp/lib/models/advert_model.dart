import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';

@immutable
class AdvertModel {
  final String id;
  final String title;
  final String userId;
  final String? description;
  final String type;
  final String? acceptedBid;
  final Domain domain;
  final double dateCreated;
  final double? dateClosed;
  final double? advertRank;
  final List<String> images; // image urls for an advert

  const AdvertModel({
    required this.id,
    required this.title,
    required this.userId,
    this.images = const [],
    this.description,
    required this.type,
    this.acceptedBid,
    required this.domain,
    required this.dateCreated,
    this.dateClosed,
    this.advertRank,
  });

  AdvertModel copy({
    String? id,
    String? title,
    String? userId,
    String? description,
    String? type,
    String? acceptedBid,
    Domain? domain,
    double? dateCreated,
    double? dateClosed,
    double? advertRank,
    List<String>? images,
  }) {
    return AdvertModel(
      id: id ?? this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      images: images ?? this.images,
      type: type ?? this.type,
      acceptedBid: acceptedBid ?? this.acceptedBid,
      domain: domain ?? this.domain,
      dateCreated: dateCreated ?? this.dateCreated,
      dateClosed: dateClosed ?? this.dateClosed,
      advertRank: advertRank ?? this.advertRank,
    );
  }

  factory AdvertModel.fromJson(obj) {
    return AdvertModel(
      id: obj['id'],
      title: obj['title'],
      userId: obj['customer_id'],
      description: obj['description'],
      type: obj['type'],
      acceptedBid: obj['accepted_bid'],
      domain: Domain.fromJson(obj['domain']),
      dateCreated: obj['date_created'].toDouble(),
      dateClosed: obj['date_closed']?.toDouble(),
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
      dateClosed == other.dateClosed &&
      advertRank == other.advertRank &&
      images == other.images;

  @override
  int get hashCode => Object.hash(
        id,
        title,
        description,
        type,
        acceptedBid,
        domain,
        dateCreated,
        dateClosed,
        advertRank,
        images,
      );
}
