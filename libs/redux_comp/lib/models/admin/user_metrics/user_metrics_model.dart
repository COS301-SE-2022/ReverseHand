import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_metrics/metrics_model.dart';
import 'package:redux_comp/models/admin/user_metrics/chart_model.dart';
import 'package:redux_comp/models/admin/user_metrics/dimensions_model.dart';

@immutable
class UserMetricsModel {
  final MetricsModel? sessionMetrics;
  final int? activeSessions;
  final List<DimensionsModel>? dimensions;
  final ChartModel? placeBidMetrics;


  const UserMetricsModel({
    this.sessionMetrics,
    this.activeSessions,
    this.dimensions,
    this.placeBidMetrics,
  });

  UserMetricsModel copy({
    MetricsModel? sessionMetrics,
    int? activeSessions,
    List<DimensionsModel>? dimensions,
    ChartModel? placeBidMetrics,
  }) {
    return UserMetricsModel(
      sessionMetrics: sessionMetrics ?? this.sessionMetrics,
      activeSessions: activeSessions ?? this.activeSessions,
            dimensions:dimensions ?? this.dimensions,
      placeBidMetrics: placeBidMetrics ?? this.placeBidMetrics,
    );
  }
}
