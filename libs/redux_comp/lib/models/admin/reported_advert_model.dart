import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/report_model.dart';
import 'package:redux_comp/models/advert_model.dart';

@immutable
class ReportedAdvertModel {
  final String customerId;
  final int count;
  final AdvertModel advert;
  final List<ReportModel> reports;
 

  const ReportedAdvertModel({
    required this.count,
    required this.customerId,
    required this.advert,
    required this.reports,
  });

  factory ReportedAdvertModel.fromJson(obj) {
    List<ReportModel> reports = [];
    for(dynamic elem in obj["reports"]) {
      reports.add(ReportModel.fromJson(elem));
    }

    return ReportedAdvertModel(
      count: obj['count'],
      customerId: obj['customer_id'],
      advert: AdvertModel.fromJson(obj["advert"]),
      reports: reports
    );
  }
}