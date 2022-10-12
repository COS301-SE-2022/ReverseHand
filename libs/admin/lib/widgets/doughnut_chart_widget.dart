import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/user_metrics/pie_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnutChartWidget extends StatelessWidget {
  final List<PieChartModel> data;
  final String chartTitle;
  const DoughnutChartWidget({
    Key? key,
    required this.data,
    required this.chartTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool nodata = true;
    for (var obs in data) {
      if (obs.value > 0) {
        nodata = false;
      }
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
          (nodata)
              ? const Padding(
                  padding: EdgeInsets.only(
                      top: 100, left: 40, right: 40, bottom: 100),
                  child: (Text(
                    "No recorded data for this date",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white70),
                  )),
                )
              : SfCircularChart(
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                    isResponsive: true,
                    textStyle:
                        const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  backgroundColor: Theme.of(context).primaryColorLight,
                  borderColor: Colors.black,
                  borderWidth: 5,
                  margin: const EdgeInsets.all(20),
                  series: [
                      DoughnutSeries<PieChartModel, String>(
                          explode: true,
                          dataSource: data,
                          dataLabelMapper: (PieChartModel obs, _) =>  obs.label,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          legendIconType: LegendIconType.verticalLine,
                          pointColorMapper: (PieChartModel obs, _) => obs.color,
                          xValueMapper: (PieChartModel obs, _) => obs.label,
                          yValueMapper: (PieChartModel obs, _) => obs.value)
                    ]),
        ],
      ),
    );
  }
}
