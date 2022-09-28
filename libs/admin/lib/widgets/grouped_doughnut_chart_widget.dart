import 'package:admin/widgets/doughnut_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/user_metrics/pie_chart_model.dart';

class GroupedDoughnutChartWidget extends StatelessWidget {
  final Map<String, List<PieChartModel>> graphs;
  const GroupedDoughnutChartWidget({
    Key? key,
    required this.graphs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DoughnutChartWidget> charts = [];
    graphs.forEach((title, data) {
      charts.add(DoughnutChartWidget(data: data, chartTitle: title));
    });
    return Column(
      children: [...charts],
    );
  }
}
