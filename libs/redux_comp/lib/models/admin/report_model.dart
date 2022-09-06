import 'package:flutter/material.dart';

@immutable
class ReportModel {
  final String reporterId;
  final String reason;
  final String description;
 

  const ReportModel({
    required this.reporterId,
    required this.reason,
    required this.description,
  });

  factory ReportModel.fromJson(obj) {
    return ReportModel(
      reporterId: obj['reporter_id'],
      reason: obj['reason'],
      description: obj['description'],
    );
  }
}