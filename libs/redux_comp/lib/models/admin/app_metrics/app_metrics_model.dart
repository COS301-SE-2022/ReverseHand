import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_metrics/line_chart_model.dart';

@immutable
class AppMetricsModel {
  //Database Write charts
  final List<LineChartModel>? dbWriteData;
  //Database Read charts
  final List<LineChartModel>? dbReadData;
  //Appsync Latency

  const AppMetricsModel({
    this.dbWriteData,
    this.dbReadData,
  });

  AppMetricsModel copy({
    List<LineChartModel>? dbWriteData,
    List<LineChartModel>? dbReadData,
  }) {
    return AppMetricsModel(
      dbWriteData: dbWriteData ?? this.dbWriteData,
      dbReadData: dbReadData ?? this.dbReadData,
    );
  }
}
