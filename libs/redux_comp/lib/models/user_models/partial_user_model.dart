/* MODDEL TO STORE USER INFO PRIOR TO CONFIRMATION */

import 'package:flutter/material.dart';
import '../geolocation/place_model.dart';

@immutable
class PartialUser {
  final String email;
  final String? name;
  final Place? place;
  final String group;
  final String verified;

  const PartialUser({required this.email, this.name, this.place, required this.group, required this.verified});

  PartialUser replace({
    String? email,
    String? name,
    Place? place,
    String? group,
    String? verified,
  }) {
    return PartialUser(
      email: email ?? this.email,
      name: name ?? this.name,
      place: place ?? this.place,
      group: group ?? this.group,
      verified: verified ?? this.verified,
    );
  }
}
