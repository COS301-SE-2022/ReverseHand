import 'package:flutter/material.dart';

@immutable
class BidModel {
  final String paymentType;
  final bool accepted;

  const BidModel(this.paymentType, this.accepted);
}