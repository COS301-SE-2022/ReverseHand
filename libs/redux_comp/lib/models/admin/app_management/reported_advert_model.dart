import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/report_details_model.dart';
import 'package:redux_comp/models/advert_model.dart';

@immutable
class ReportedAdvertModel {
  final int count;
  final AdvertModel advert;
  final List<ReportDetailsModel> reports;

  const ReportedAdvertModel({
    required this.count,
    required this.advert,
    required this.reports,
  });

  ReportedAdvertModel copy({
    int? count,
    AdvertModel? advert,
    List<ReportDetailsModel>? reports,
  }) {
    return ReportedAdvertModel(
        count: count ?? this.count,
        advert: advert ?? this.advert,
        reports: reports ?? this.reports);
  }

  factory ReportedAdvertModel.fromJson(obj) {
    List<ReportDetailsModel> reports = [];
    for (dynamic elem in obj["reports"]) {
      reports.add(ReportDetailsModel.fromJson(elem));
    }

    return ReportedAdvertModel(
        count: obj['count'],
        advert: AdvertModel.fromJson(obj['advert']),
        reports: reports);
  }
}
