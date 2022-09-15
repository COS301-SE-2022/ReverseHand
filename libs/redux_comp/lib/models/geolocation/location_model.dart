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

  @override
  String toString() {
    return """{
      address : {
        streetNumber : "${address.streetNumber}",
        street : "${address.street}",
        city : "${address.city}",
        province : "${address.province}",
        zipCode : "${address.zipCode}"
      },
      coordinates : {
        lat : ${coordinates.lat},
        lng : ${coordinates.lng}
      }
    }""";
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      address: Address(
        streetNumber: json['address']['streetNumber'],
        street: json['address']['street'],
        city: json['address']['city'],
        province: json['address']['province'],
        zipCode: json['address']['zipCode'],
      ),
      coordinates: Coordinates.fromJson(json['coordinates']),
    );
  }

  @override
  int get hashCode => Object.hash(address, coordinates);

  @override
  bool operator ==(Object other) {
    return other is Location &&
        address == other.address &&
        coordinates == other.coordinates;
  }
}
