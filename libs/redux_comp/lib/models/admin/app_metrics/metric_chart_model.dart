import 'package:flutter/material.dart';

@immutable
class MetricChartModel {
  final String title;
  final String label;
  final List<double> values;
  final List<String> times;
  // final ReportDetailsModel? reviewDetails;
 

  const MetricChartModel({
    required this.title,
    required this.label,
    required this.values,
    required this.times,
    // required this.reviewDetails,
  });

  factory MetricChartModel.fromJson(obj) {
    return MetricChartModel(
      title: "Title",
      label: obj['Label'],
      times: obj['TimeStamps'],
      values: obj['Values'],
      // reviewDetails: ReportDetailsModel.fromJson(obj["report_details"]),
    );
  }
}