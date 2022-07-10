/* MODDEL TO STORE USER INFO PRIOR TO CONFIRMATION */

import 'package:flutter/material.dart';
import '../geolocation/place_model.dart';

@immutable
class PartialUser {
  final String email;
  final String? id;
  final String? password;
  final String? name;
  final String? cellNo;
  final Place? place;
  final String group;
  final String verified;

  const PartialUser({required this.email, this.id, this.password, this.name, this.cellNo, this.place, required this.group, required this.verified});

  PartialUser replace({
    String? email,
    String? id,
    String? password,
    String? name,
    String? cellNo,
    Place? place,
    String? group,
    String? verified,
  }) {
    return PartialUser(
      email: email ?? this.email,
      id: id ?? this.id,
      password: password ?? this.password,
      name: name ?? this.name,
      cellNo: cellNo ?? this.cellNo,
      place: place ?? this.place,
      group: group ?? this.group,
      verified: verified ?? this.verified,
    );
  }
}
