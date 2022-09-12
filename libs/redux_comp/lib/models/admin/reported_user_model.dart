import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/report_model.dart';

@immutable
class ReportedUserModel {
  final String id;
  final String name;
  final String email;
  final String cellNo;
  final List<ReportModel> reports;
 

  const ReportedUserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.cellNo,
    required this.reports,
  });

  factory ReportedUserModel.fromJson(obj) {
    List<ReportModel> reports = [];
    for(dynamic report in obj["user_reports"]) {
      reports.add(ReportModel.fromJson(report));
    }

    return ReportedUserModel(
      id: obj['id'],
      name: obj['name'],
      email: obj['email'],
      cellNo: obj['cellNo'],
      reports: reports
    );
  }
}