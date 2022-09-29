import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_metrics/line_chart_model.dart';
//for a group of line charts...
@immutable
class MetricsModel {
  final int period;
  final int time;
  final Map<String ,List<LineChartModel>> graphs;

  const MetricsModel({
    required this.period, 
    required this.time,
    required this.graphs,
  });

  MetricsModel copy({
    int? period,
    int? time,
    Map<String, List<LineChartModel>>? graphs
  }) {
    return MetricsModel(
      period: period ?? this.period,
      time: time ?? this.time,
      graphs: graphs ?? this.graphs,
    );
  }
}
