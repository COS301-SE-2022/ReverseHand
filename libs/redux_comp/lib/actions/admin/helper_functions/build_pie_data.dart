import 'package:redux_comp/models/admin/user_metrics/pie_chart_model.dart';

PieChartModel buildPieData(obj) {
  int length = obj["Values"].length;
  num total = 0;

  for (var i = 0; i < length; i++) {
    total += obj["Values"][i];
  }

  return PieChartModel(label: obj["Id"], value: total);
}
