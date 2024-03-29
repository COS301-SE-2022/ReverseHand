import 'package:flutter/material.dart';

@immutable
class Address {
  final String streetNumber;
  final String street;
  final String city;
  final String province;
  final String zipCode;

  const Address({
    required this.streetNumber,
    required this.street,
    required this.city,
    required this.province,
    required this.zipCode,
  });

  Address replace({
    String? streetNumber,
    String? street,
    String? city,
    String? province,
    String? zipCode,
  }) {
    return Address(
      streetNumber: streetNumber ?? this.streetNumber,
      street: street ?? this.street,
      city: city ?? this.city,
      province: province ?? this.province,
      zipCode: zipCode ?? this.zipCode,
    );
  }

  @override
  int get hashCode =>
      Object.hash(streetNumber, street, city, province, zipCode);

  @override
  bool operator ==(Object other) {
    return other is Address &&
        streetNumber == other.streetNumber &&
        street == other.street &&
        city == other.city &&
        province == other.province &&
        zipCode == other.zipCode;
  }
}
