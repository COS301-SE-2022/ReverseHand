import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_metrics/metrics_model.dart';

@immutable
class UserMetricsModel {
  final MetricsModel? sessionMetrics;
  final int? activeSessions;

  const UserMetricsModel({
    this.sessionMetrics,
    this.activeSessions,
  });

  UserMetricsModel copy({
    MetricsModel? sessionMetrics,
    int? activeSessions,
  }) {
    return UserMetricsModel(
      sessionMetrics: sessionMetrics ?? this.sessionMetrics,
      activeSessions: activeSessions ?? this.activeSessions,
    );
  }
}
