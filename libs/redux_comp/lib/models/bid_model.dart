import 'package:flutter/material.dart';

@immutable
class BidModel {
  final String id;
  final String? name;
  final String userId;
  final int priceLower;
  final int priceUpper;
  final String? quote;
  final String dateCreated; // change later to json/map object
  final String? dateClosed; // change later to json/map object

  const BidModel({
    required this.id,
    required this.userId,
    required this.priceLower,
    required this.priceUpper,
    this.quote,
    this.name,
    required this.dateCreated,
    this.dateClosed,
  });

  bool isShortlisted() {
    return id.contains('sb');
  }

  factory BidModel.fromJson(obj) {
    return BidModel(
      id: obj['id'],
      userId: obj['user_id'],
      priceLower: obj['price_lower'],
      priceUpper: obj['price_upper'],
      quote: obj['quote'],
      dateCreated: obj['date_created'],
      dateClosed: obj['date_Closed'],
    );
  }
}
