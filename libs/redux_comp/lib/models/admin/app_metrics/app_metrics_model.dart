import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_metrics/line_chart_model.dart';
import 'package:redux_comp/models/admin/app_metrics/metrics_model.dart';

@immutable
class AppMetricsModel {
  final MetricsModel? databaseMetrics;
  //Database Write charts
  final List<LineChartModel>? dbWriteData;
  //Database Read charts
  final List<LineChartModel>? dbReadData;
  //Appsync Latency

  const AppMetricsModel({
    this.databaseMetrics,
    this.dbWriteData,
    this.dbReadData,
  });

  AppMetricsModel copy({
    MetricsModel? databaseMetrics,
    List<LineChartModel>? dbWriteData,
    List<LineChartModel>? dbReadData,
  }) {
    return AppMetricsModel(
      databaseMetrics: databaseMetrics ?? this.databaseMetrics,
      dbWriteData: dbWriteData ?? this.dbWriteData,
      dbReadData: dbReadData ?? this.dbReadData,
    );
  }
}
