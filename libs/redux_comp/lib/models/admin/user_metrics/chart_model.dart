import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/user_metrics/pie_chart_model.dart';
//for a group of pie charts ... 
@immutable
class ChartModel {
  final DateTime time;
  final Map<String ,List<PieChartModel>> graphs;

  const ChartModel({
    required this.time,
    required this.graphs,
  });

  ChartModel copy({
    DateTime? time,
    Map<String, List<PieChartModel>>? graphs,
  }) {
    return ChartModel(
      time: time ?? this.time,
      graphs: graphs ?? this.graphs,
    );
  }
}
