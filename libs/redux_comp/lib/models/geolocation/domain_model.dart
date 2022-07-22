import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';

@immutable
class Domain {
  final String city;
  final Coordinates coordinates;

  const Domain({
    required this.city,
    required this.coordinates,
  });

  Domain copy({
    String? city,
    Coordinates? coordinates,
  }) {
    return Domain(
      city: city ?? this.city,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  factory Domain.fromJson(Map<String, dynamic> json) {
    return Domain(
      city: json['city'],
      coordinates: Coordinates.fromJson(json['coordinates']),
    );
  }
}
