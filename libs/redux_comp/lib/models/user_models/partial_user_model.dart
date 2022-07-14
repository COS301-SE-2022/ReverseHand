/* MODDEL TO STORE USER INFO PRIOR TO CONFIRMATION */

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

@immutable
class PartialUser {
  final String email;
  final String? name;
  final Position? position;
  final String group;
  final String verified;

  const PartialUser({required this.email, this.name, this.position, required this.group, required this.verified});

  PartialUser replace({
    String? email,
    String? name,
    Position? position,
    String? group,
    String? verified,
  }) {
    return PartialUser(
      email: email ?? this.email,
      name: name ?? this.name,
      position: position ?? this.position,
      group: group ?? this.group,
      verified: verified ?? this.verified,
    );
  }
}
