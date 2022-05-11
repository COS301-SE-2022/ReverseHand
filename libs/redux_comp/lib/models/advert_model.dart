import 'package:flutter/material.dart';
import 'bids_model.dart';

@immutable
class AdvertModel {
  final String title;
  final String description;
  final List<BidModel> bids;

  const AdvertModel(this.title, this.description, this.bids);
}