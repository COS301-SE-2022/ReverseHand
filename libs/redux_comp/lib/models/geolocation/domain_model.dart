import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';

@immutable
class Domain {
  final String city;
  final String province;
  final Coordinates coordinates;

  const Domain({
    required this.city,
    required this.province,
    required this.coordinates,
  });

  Domain copy({
    String? city,
    String? province,
    Coordinates? coordinates,
  }) {
    return Domain(
      city: city ?? this.city,
      province: province ?? this.province,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  @override
  String toString() {
    return """{
      city : "$city",
      province : "$province",
      coordinates : {
        lat: ${coordinates.lat},
        lng: ${coordinates.lng},
      }
    }""";
  }

  factory Domain.fromJson(Map<String, dynamic> json) {
    return Domain(
      city: json['city'],
      province: json['province'],
      coordinates: Coordinates.fromJson(json['coordinates']),
    );
  }

  @override
  int get hashCode => Object.hash(city, coordinates);

  @override
  bool operator ==(Object other) {
    return other is Domain &&
        city == other.city &&
        coordinates == other.coordinates;
  }
}
