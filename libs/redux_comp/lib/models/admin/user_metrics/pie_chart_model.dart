import 'package:flutter/material.dart';

@immutable
class PieChartModel {
  final String label;
  final num value;
  final Color? color;
 

  const PieChartModel({
    required this.label,
    required this.value,
    this.color,
  });
}