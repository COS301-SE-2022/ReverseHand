import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/observation_model.dart';

@immutable
class MetricChartModel {
  final String title;
  final List<ObservationModel> data;
  // final ReportDetailsModel? reviewDetails;
 

  const MetricChartModel({
    required this.title,
    required this.data,
    // required this.reviewDetails,
  });

  factory MetricChartModel.fromJson(obj) {
    int length = obj["Values"].length;
    
    List<ObservationModel> data = [];
    int i = length;
    while (i > 0) {
      i--;
      data.add(ObservationModel(time: (obj["Timestamps"][i]).substring(11,16), value: obj['Values'][i]));

    }
    return MetricChartModel(
      title: "Title",
      data: data
      // reviewDetails: ReportDetailsModel.fromJson(obj["report_details"]),
    );
  }
}