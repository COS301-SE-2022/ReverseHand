import 'package:redux_comp/models/admin/user_metrics/dimensions_model.dart';

List<dynamic> buildDimensionsQuery(List<DimensionsModel> dimensions) {
  List<dynamic> queries = [];

  for (var dimension in dimensions) {
    for (var dimeNames in dimension.dimensions) {
      if (dimeNames["Name"] != "Amount") {
        queries.add({
          "Id": 'placeBid${dimeNames["Value"]}',
          "MetricStat": {
            "Metric": {
              "Dimensions": [
                {
                  "Name": dimeNames["Name"],
                  "Value": dimeNames["Value"],
                },
              ],
              "MetricName": 'PlaceBid',
              "Namespace": 'CustomEvents'
            },
            "Period": '60',
            "Stat": 'Sum',
          },
          "ReturnData": true
        });
      }
    }
  }
  return queries;
}
