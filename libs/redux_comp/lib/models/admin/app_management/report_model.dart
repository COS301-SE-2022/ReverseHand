import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/report_details_model.dart';

@immutable
class ReportModel {
  final String id;
  final String type;
  final ReportDetailsModel reportDetails;
  // final ReportDetailsModel? reviewDetails;
 

  const ReportModel({
    required this.id,
    required this.type,
    required this.reportDetails,
    // required this.reviewDetails,
  });

  factory ReportModel.fromJson(obj) {
    return ReportModel(
      id: obj['id'],
      type: obj['report_type'],
      reportDetails: ReportDetailsModel.fromJson(obj["report_details"]),
      // reviewDetails: ReportDetailsModel.fromJson(obj["report_details"]),
    );
  }
}