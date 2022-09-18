import 'package:admin/widgets/system_charts/line_chart_widget.dart';
import 'package:flutter/material.dart';

class DisplayMetricsConatinerWidget extends StatelessWidget {
  final List<LineChartWidget> charts;
  const DisplayMetricsConatinerWidget({
    Key? key,
    required this.charts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.7),
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [...charts],
        ));
  }
}
