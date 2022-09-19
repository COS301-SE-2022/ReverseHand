import 'package:flutter/material.dart';

@immutable
class BidModel {
  final String id;
  final String? name;
  final String userId;
  final int price;
  final String? quote;
  final double dateCreated; // change later to json/map object
  final double? dateClosed; // change later to json/map object
  final bool shortlisted;

  const BidModel({
    required this.id,
    required this.userId,
    required this.price, // in cents
    this.quote,
    this.name,
    required this.dateCreated,
    this.dateClosed,
    required this.shortlisted,
  });

  // gets the amount in rands of a bid
  String amount() {
    return 'R${price ~/ 100}';
  }

  factory BidModel.fromJson(obj) {
    return BidModel(
        id: obj['id'],
        userId: obj['tradesman_id'],
        name: obj['name'],
        price: obj['price'],
        quote: obj['quote'],
        dateCreated: double.parse(obj['date_created']),
        dateClosed: (obj['date_Closed'] != null)
            ? double.parse(obj['date_Closed'])
            : null,
        shortlisted: obj['shortlisted']);
  }
}
