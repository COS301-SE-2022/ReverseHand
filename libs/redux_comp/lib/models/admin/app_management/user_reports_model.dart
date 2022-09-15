import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/report_model.dart';

@immutable
class UserReportsModel {
  final String nextToken;
  final List<ReportModel> userReports;
 

  const UserReportsModel({
    required this.nextToken,
    required this.userReports,
  });

  factory UserReportsModel.fromJson(obj) {
    List<ReportModel> reports = [];
    for(dynamic report in obj["user_reports"]) {
      reports.add(ReportModel.fromJson(report));
    }

    return UserReportsModel(
      nextToken: obj['id'],
      userReports: reports,
    );
  }
}