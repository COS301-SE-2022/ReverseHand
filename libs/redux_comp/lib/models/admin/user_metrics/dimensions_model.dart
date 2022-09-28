import 'package:flutter/material.dart';

@immutable
class DimensionsModel {
  final String nameSpace;
  final String metricName;
  final List<Map<String, String>> dimensions;

  const DimensionsModel({
    required this.nameSpace,
    required this.metricName,
    required this.dimensions,
  });

  DimensionsModel copy({
    String? nameSpace,
    String? metricName,
    List<Map<String, String>>? dimensions,
  }) {
    return DimensionsModel(
      nameSpace: nameSpace ?? this.nameSpace,
      metricName: metricName ?? this.metricName,
      dimensions: dimensions ?? this.dimensions,
    );
  }

  factory DimensionsModel.fromJson(obj) {
    List<Map<String, String>> dimens = [];
    List dimensions = obj["Dimensions"];

    for (var dimension in dimensions) {
      if (dimension["Value"] != "N/A") {
        dimens.add({"Name": dimension["Name"], "Value": dimension["Value"]});
      }
    }

    return DimensionsModel(
      nameSpace: obj["Namespace"],
      metricName: obj["MetricName"],
      dimensions: dimens,
    );
  }
}
