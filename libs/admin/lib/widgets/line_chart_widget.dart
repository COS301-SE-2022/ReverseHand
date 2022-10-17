import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';
import 'package:redux_comp/models/admin/app_metrics/line_chart_model.dart';
import 'package:redux_comp/models/admin/app_metrics/observation_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartWidget extends StatefulWidget {
  final List<LineChartModel> graphs;
  final String chartTitle;
  final String xTitle;
  final String yTitle;
  const LineChartWidget({
    Key? key,
    required this.graphs,
    required this.chartTitle,
    required this.xTitle,
    required this.yTitle,
  }) : super(key: key);

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  late ZoomPanBehavior _zoomingPanBehavior;
  @override
  void initState() {
    _zoomingPanBehavior = ZoomPanBehavior(
        enablePanning: true,
        enablePinching: true,
        enableSelectionZooming: true,
        selectionRectBorderColor: Colors.orange,
        selectionRectBorderWidth: 1,
        selectionRectColor: Colors.grey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ChartSeries<ObservationModel, String>> list = [];
    for (LineChartModel data in widget.graphs) {
      list.add(
        LineSeries<ObservationModel, String>(
            dataSource: data.data,
            color: data.color,
            xValueMapper: (ObservationModel obs, _) => obs.time,
            yValueMapper: (ObservationModel obs, _) => obs.value,
            markerSettings: MarkerSettings(
                isVisible: true, color: data.color, height: 5, width: 5),
            name: data.label,
            emptyPointSettings: EmptyPointSettings(mode: EmptyPointMode.gap)),
      );
    }

    Widget chart = SfCartesianChart(
      enableAxisAnimation: true,
      zoomPanBehavior: _zoomingPanBehavior,
      tooltipBehavior: TooltipBehavior(enable: true),
      legend: Legend(
          position: LegendPosition.bottom,
          isVisible: true,
          textStyle: const TextStyle(color: Colors.white),
          overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: CategoryAxis(
          labelStyle: const TextStyle(color: Colors.white),
          title: AxisTitle(
              text: widget.xTitle,
              textStyle: const TextStyle(color: Colors.white, fontSize: 12.5))),
      primaryYAxis: NumericAxis(
          labelStyle: const TextStyle(color: Colors.white),
          title: AxisTitle(
              text: widget.yTitle,
              textStyle: const TextStyle(color: Colors.white, fontSize: 12.5)),
          isVisible: true),
      backgroundColor: Theme.of(context).primaryColorLight,
      borderColor: Colors.black,
      borderWidth: 5,
      margin: const EdgeInsets.all(20),
      series: list,
    );

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.chartTitle,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: ButtonWidget(
                    function: () {
                      _zoomingPanBehavior.reset();
                    },
                    text: "Reset",
                    color: "dark",
                    size: 15,
                  )),
            ],
          ),
          chart
        ],
      ),
    );
  }
}
