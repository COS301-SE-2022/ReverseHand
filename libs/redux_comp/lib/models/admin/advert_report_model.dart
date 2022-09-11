import 'package:flutter/material.dart';

@immutable
class AdvertReportModel {
  final String tradesmanId;
  final String reason;
  final String description;
 

  const AdvertReportModel({
    required this.tradesmanId,
    required this.reason,
    required this.description,
  });

  factory AdvertReportModel.fromJson(obj) {
    return AdvertReportModel(
      tradesmanId: obj['tradesman_id'],
      reason: obj['reason'],
      description: obj['description'],
    );
  }
}