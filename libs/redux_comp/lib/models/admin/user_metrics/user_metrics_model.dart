import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_metrics/metrics_model.dart';
import 'package:redux_comp/models/admin/user_metrics/chart_model.dart';
import 'package:redux_comp/models/admin/user_metrics/dimensions_model.dart';

@immutable
class UserMetricsModel {
  final MetricsModel? sessionMetrics;
  final int? activeSessions;
  final ChartModel? placeBidMetrics;
  final Map<String, List<DimensionsModel>>? dimensions;

  const UserMetricsModel(
      {this.sessionMetrics,
      this.activeSessions,
      this.placeBidMetrics,
      this.dimensions});

  UserMetricsModel copy({
    MetricsModel? sessionMetrics,
    int? activeSessions,
    ChartModel? placeBidMetrics,
    Map<String, List<DimensionsModel>>? dimensions,
  }) {
    return UserMetricsModel(
      sessionMetrics: sessionMetrics ?? this.sessionMetrics,
      activeSessions: activeSessions ?? this.activeSessions,
      placeBidMetrics: placeBidMetrics ?? this.placeBidMetrics,
      dimensions: dimensions ?? this.dimensions,
    );
  }
}
