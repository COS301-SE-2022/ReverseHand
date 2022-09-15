import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_metrics/metric_chart_model.dart';

@immutable
class AppMetricsModel {
  final MetricChartModel? dbWriteGraph;

  const AppMetricsModel({
    this.dbWriteGraph,
  });

  AppMetricsModel copy({MetricChartModel? dbWriteGraph}) {
    return AppMetricsModel(
      dbWriteGraph: dbWriteGraph ?? this.dbWriteGraph,
    );
  }

  factory AppMetricsModel.fromJson(obj) {
    return AppMetricsModel(
      dbWriteGraph: MetricChartModel.fromJson(obj),
    );
  }
}
