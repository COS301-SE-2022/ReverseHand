import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/models/review_report_details.dart';
import 'package:redux_comp/models/admin/app_management/report_details_model.dart';

@immutable
class ReportModel {
  final String id;
  final String type;
  final ReportDetailsModel reportDetails;
  final String? userId;
  final ReviewDetailsModel? reviewDetails;

  const ReportModel({
    required this.id,
    required this.type,
    required this.reportDetails,
    this.userId,
    this.reviewDetails,
  });

  factory ReportModel.fromJson(obj) {
    if (obj["review_details"] != null) {
      return ReportModel(
        id: obj['id'],
        userId: obj['user_id'],
        type: obj['report_type'],
        reportDetails: ReportDetailsModel.fromJson(obj["report_details"]),
        reviewDetails: ReviewDetailsModel.fromJson(obj["review_details"]),
      );
    } else {
      return ReportModel(
        id: obj['id'],
        type: obj['report_type'],
        reportDetails: ReportDetailsModel.fromJson(obj["report_details"]),
      );
    }
  }
}
