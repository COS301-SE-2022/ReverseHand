import 'package:flutter/material.dart';

@immutable
class ObservationModel {
  final String time;
  final num? value;
 

  const ObservationModel({
    required this.time,
    this.value,
  });

}