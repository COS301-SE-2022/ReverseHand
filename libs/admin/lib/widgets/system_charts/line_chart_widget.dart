
import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_metrics/metric_chart_model.dart';
import 'package:redux_comp/models/admin/observation_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartWidget extends StatelessWidget {
  final MetricChartModel data;
  const LineChartWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        // Chart title
        title: ChartTitle(text: data.title),
        // Enable legend
        legend: Legend(isVisible: false),
        backgroundColor: Colors.white,
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<ObservationModel, String>>[
          LineSeries<ObservationModel, String>(
              dataSource: data.data,
              xValueMapper: (ObservationModel obs, _) => obs.time,
              yValueMapper: (ObservationModel obs, _) => obs.value,
              name: 'Write capacity',
              // Enable data label
              dataLabelSettings: const DataLabelSettings(isVisible: true))
        ]);
  }
}
