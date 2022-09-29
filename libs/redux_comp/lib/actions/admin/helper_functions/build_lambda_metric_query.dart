Map<String, dynamic> buildLambdaMetricQuery(
    String name, String stat, String label, int paramsPeriod) {
  return {
    "Id": name,
    "Label": label,
    "MetricStat": {
      "Metric": {
        "Dimensions": [
          {
            "Name": 'FunctionName',
            "Value": "$name-staging",
          }
        ],
        "MetricName": stat,
        "Namespace": 'AWS/Lambda'
      },
      "Period": paramsPeriod, // day
      "Stat": 'Sum',
      "Unit": 'Count',
    },
  };
}