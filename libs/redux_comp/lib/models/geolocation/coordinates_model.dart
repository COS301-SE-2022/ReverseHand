import 'package:flutter/material.dart';

@immutable
class Coordinates {
  final double lat;
  final double long;

  const Coordinates({required this.lat, required this.long});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lat: json['lat'],
      long: json['lng'],
    );
  }
}
