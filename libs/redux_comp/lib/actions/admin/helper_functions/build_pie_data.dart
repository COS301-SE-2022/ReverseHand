import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/user_metrics/pie_chart_model.dart';

List<Color> colors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.purple,
  Colors.yellow,
];

PieChartModel buildPieData(obj, int color) {
  int length = obj["Values"].length;
  num total = 0;

  for (var i = 0; i < length; i++) {
    total += obj["Values"][i];
  }
  return PieChartModel(label: obj["Id"], value: total, color: colors[color % colors.length]);
}
