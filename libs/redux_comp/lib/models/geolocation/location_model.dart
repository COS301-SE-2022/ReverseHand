import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/address_model.dart';
import 'package:redux_comp/models/geolocation/coordinates_model.dart';

@immutable
class Location {
  final Address address;
  final Coordinates coordinates;

  const Location({
    required this.address,
    required this.coordinates,
   
  });

  Location replace({
    Address? address,
    Coordinates? coordinates,
  }) {
    return Location(
      address: address ?? this.address,
      coordinates: coordinates ?? this.coordinates,
    );
  }
}
