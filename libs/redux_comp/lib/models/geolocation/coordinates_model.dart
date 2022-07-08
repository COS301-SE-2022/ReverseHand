import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/place_model.dart';
import 'package:redux_comp/models/geolocation/suggestion_model.dart';

@immutable
class Coordinates {
  final double? lat;
  final double? long;

  const Coordinates({
    this.lat, this.long
  });

  Coordinates replace({
    double? lat,
    double? long
  }) {
    return Coordinates(
      lat: lat ?? this.lat,
      long: long ?? this.long
    );
  }
}