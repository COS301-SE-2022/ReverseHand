import 'package:redux_comp/models/admin/user_metrics/dimensions_model.dart';

List<dynamic> buildDimensionsQuery(
    List<DimensionsModel> dimensions, String event) {
  List<dynamic> queries = [];

  for (var dimension in dimensions) {
    for (var dimeNames in dimension.dimensions) {
      String id = "";
      switch (event) {
        case "PlaceBid":
          id = (dimeNames["Name"] == "Job_Type")
              ? dimeNames["Value"]?.toLowerCase() ?? ""
              : (dimeNames["Value"] == "amount <= 500")
                  ? "lessThan500"
                  : (dimeNames["Value"] == "500 < amount <= 2500")
                      ? "between500and2500"
                      : (dimeNames["Value"] == "2500 < amount < 10000")
                          ? "between2500and10000"
                          : "greaterThan10000";
          break;
        case "CreateAdvert": 
          id = dimeNames["Value"]?.toLowerCase() ?? "";
          break;
      }

      queries.add({
        "Id": id,
        "MetricStat": {
          "Metric": {
            "Dimensions": [
              {
                "Name": dimeNames["Name"].toString(),
                "Value": dimeNames["Value"].toString(),
              },
            ],
            "MetricName": event,
            "Namespace": 'CustomEvents'
          },
          "Period": '60',
          "Stat": 'Sum',
        },
        "ReturnData": true
      });
    }
  }
  return queries;
}
