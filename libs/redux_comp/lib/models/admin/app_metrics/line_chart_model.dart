import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_metrics/observation_model.dart';

@immutable
class LineChartModel {
  final String label;
  final Color color;
  final List<ObservationModel> data;
 

  const LineChartModel({
    required this.label,
    required this.color,
    required this.data,
  });
}