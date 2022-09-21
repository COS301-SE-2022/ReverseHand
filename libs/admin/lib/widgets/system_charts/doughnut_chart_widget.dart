import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/user_metrics/pie_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnutChartWidget extends StatelessWidget {
  final List<PieChartModel> graphs;
  final String chartTitle;
  const DoughnutChartWidget({
    Key? key,
    required this.graphs,
    required this.chartTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DoughnutSeries<PieChartModel, String>> list = [];
    for (PieChartModel data in graphs) {
      list.add(DoughnutSeries<PieChartModel, String>(
          explode: true,
          dataSource: graphs,
          legendIconType: LegendIconType.verticalLine,
          pointColorMapper: (PieChartModel obs, _) => obs.color,
          xValueMapper: (PieChartModel obs, _) => obs.label,
          yValueMapper: (PieChartModel obs, _) => obs.value));
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
                    color: Colors.white,
                    fontSize: 20,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SfCircularChart(
              legend: Legend(
                  isVisible: true,
                  isResponsive: true,
                  textStyle: const TextStyle(fontSize: 10,color: Colors.white),
                  ),
              backgroundColor: Theme.of(context).primaryColorLight,
              borderColor: Colors.black,
              borderWidth: 5,
              margin: const EdgeInsets.all(20),
              series: list),
        ],
      ),
    );
  }
}
