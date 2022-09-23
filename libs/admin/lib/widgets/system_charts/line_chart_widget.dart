import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_metrics/line_chart_model.dart';
import 'package:redux_comp/models/admin/app_metrics/observation_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartWidget extends StatelessWidget {
  final List<LineChartModel> graphs;
  final String chartTitle;
  final String xTitle;
  final String yTitle;
  const LineChartWidget(
      {Key? key,
      required this.graphs,
      required this.chartTitle,
      required this.xTitle,
      required this.yTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ChartSeries<ObservationModel, String>> list = [];
    for (LineChartModel data in graphs) {
      list.add(
        LineSeries<ObservationModel, String>(
          dataSource: data.data,
          color: data.color,
          xValueMapper: (ObservationModel obs, _) => obs.time,
          yValueMapper: (ObservationModel obs, _) => obs.value,
          markerSettings: MarkerSettings(
              isVisible: true, color: data.color, height: 5, width: 5),
          name: data.label,
          emptyPointSettings: EmptyPointSettings(mode: EmptyPointMode.gap)
        ),
      );
    }  

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                chartTitle,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SfCartesianChart(
            enableAxisAnimation: true,
            tooltipBehavior: TooltipBehavior(enable: true),
            legend: Legend(
              position: LegendPosition.bottom,
              isVisible: true,
              textStyle: const TextStyle(color: Colors.white),
            ),
            primaryXAxis: CategoryAxis(
                labelStyle: const TextStyle(color: Colors.white),
                title: AxisTitle(
                    text: xTitle,
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 12.5))),
            primaryYAxis: NumericAxis(
                labelStyle: const TextStyle(color: Colors.white),
                title: AxisTitle(
                    text: yTitle,
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 12.5)),
                isVisible: true),
            backgroundColor: Theme.of(context).primaryColorLight,
            borderColor: Colors.black,
            borderWidth: 5,
            margin: const EdgeInsets.all(20),
            series: list,
          )
        ],
      ),
    );
  }
}
