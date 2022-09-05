import 'package:flutter/material.dart';

@immutable
class BidModel {
  final String id;
  final String? name;
  final String userId;
  final int priceLower;
  final int priceUpper;
  final String? quote;
  final double dateCreated; // change later to json/map object
  final double? dateClosed; // change later to json/map object
  final bool shortlisted;

  const BidModel({
    required this.id,
    required this.userId,
    required this.priceLower,
    required this.priceUpper,
    this.quote,
    this.name,
    required this.dateCreated,
    this.dateClosed,
    required this.shortlisted,
  });

  bool isShortlisted() {
    return id.contains('sb');
  }

  factory BidModel.fromJson(obj) {
    return BidModel(
        id: obj['id'],
        userId: obj['tradesman_id'],
        name: obj['name'],
        priceLower: obj['price_lower'],
        priceUpper: obj['price_upper'],
        quote: obj['quote'],
        dateCreated: double.parse(obj['date_created']),
        dateClosed: (obj['date_Closed'] != null)
            ? double.parse(obj['date_Closed'])
            : null,
        shortlisted: obj['shortlisted']);
  }
}
