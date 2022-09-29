import 'package:flutter/material.dart';

@immutable
class Coordinates {
  final double lat;
  final double lng;

  const Coordinates({required this.lat, required this.lng});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  @override
  int get hashCode => Object.hash(lat, lng);

  @override
  bool operator ==(Object other) {
    return other is Coordinates && lat == other.lat && lng == other.lng;
  }
}
