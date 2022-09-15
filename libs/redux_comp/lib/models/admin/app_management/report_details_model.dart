import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/models/report_user_details_model.dart';

@immutable
class ReportDetailsModel {
  final String description;
  final String reason;
  final ReportUserDetailsModel reportedUser;
  final ReportUserDetailsModel reporterUser;

  const ReportDetailsModel({
    required this.description,
    required this.reason,
    required this.reportedUser,
    required this.reporterUser,
  });

  factory ReportDetailsModel.fromJson(obj) {
    return ReportDetailsModel(
      description: obj['description'],
      reason: obj['reason'],
      reportedUser: ReportUserDetailsModel.fromJson(obj['reported_user']),
      reporterUser: ReportUserDetailsModel.fromJson(obj['reporter_user']),
    );
  }
}
