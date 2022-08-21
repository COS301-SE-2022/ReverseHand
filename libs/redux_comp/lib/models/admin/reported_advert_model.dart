import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/advert_report_model.dart';
import 'package:redux_comp/models/advert_model.dart';

@immutable
class ReportedAdvertModel {
  final String id;
  final int count;
  final AdvertModel advert;
  final List<AdvertReportModel> reports;
 

  const ReportedAdvertModel({
    required this.id,
    required this.count,
    required this.advert,
    required this.reports,
  });

  factory ReportedAdvertModel.fromJson(obj) {
    List<AdvertReportModel> reports = [];
    for(dynamic elem in obj["reports"]) {
      reports.add(AdvertReportModel.fromJson(elem));
    }

    return ReportedAdvertModel(
      id: obj['id'],
      count: obj['count'],
      advert: AdvertModel.fromJson(obj["advert"]),
      reports: reports
    );
  }
}