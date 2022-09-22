import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/observation_model.dart';

@immutable
class LineChartModel {
  final String label;
  final Color color;
  final List<ObservationModel> data;
  // final ReportDetailsModel? reviewDetails;
 

  const LineChartModel({
    required this.label,
    required this.color,
    required this.data,
    // required this.reviewDetails,
  });
}