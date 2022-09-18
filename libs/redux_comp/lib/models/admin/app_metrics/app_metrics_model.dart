import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_metrics/line_chart_model.dart';
import 'package:redux_comp/models/admin/app_metrics/metrics_model.dart';

@immutable
class AppMetricsModel {
  final MetricsModel? databaseMetrics;
  final MetricsModel? apiMetrics;

  const AppMetricsModel({
    this.databaseMetrics,
    this.apiMetrics,
  });

  AppMetricsModel copy({
    MetricsModel? databaseMetrics,
    MetricsModel? apiMetrics,
  }) {
    return AppMetricsModel(
      databaseMetrics: databaseMetrics ?? this.databaseMetrics,
      apiMetrics: apiMetrics ?? this.apiMetrics,
    );
  }
}
