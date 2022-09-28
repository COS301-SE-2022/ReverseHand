import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_metrics/metrics_model.dart';

@immutable
class AppMetricsModel {
  final MetricsModel? databaseMetrics;
  final MetricsModel? apiMetrics;
  final MetricsModel? adminResolvers;
  final MetricsModel? authMetrics;

  const AppMetricsModel({
    this.databaseMetrics,
    this.apiMetrics,
    this.adminResolvers,
    this.authMetrics,
  });

  AppMetricsModel copy({
    MetricsModel? databaseMetrics,
    MetricsModel? apiMetrics,
    MetricsModel? adminResolvers,
    MetricsModel? authMetrics,
  }) {
    return AppMetricsModel(
      databaseMetrics: databaseMetrics ?? this.databaseMetrics,
      apiMetrics: apiMetrics ?? this.apiMetrics,
      adminResolvers: adminResolvers ?? this.adminResolvers,
      authMetrics: authMetrics ?? this.authMetrics,
    );
  }
}
