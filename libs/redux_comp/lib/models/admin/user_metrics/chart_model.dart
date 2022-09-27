import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/user_metrics/pie_chart_model.dart';
//for a group of pie charts ... 
@immutable
class ChartModel {
  final Map<String ,List<PieChartModel>> graphs;


  const ChartModel({
    required this.graphs,
  });

  ChartModel copy({
    Map<String, List<PieChartModel>>? graphs,
  }) {
    return ChartModel(
      graphs: graphs ?? this.graphs,
    );
  }
}
