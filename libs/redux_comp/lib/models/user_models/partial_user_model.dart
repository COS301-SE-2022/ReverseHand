/* MODDEL TO STORE USER INFO PRIOR TO CONFIRMATION */

import 'package:flutter/material.dart';
import '../geolocation/place_model.dart';

@immutable
class PartialUser {
  final String email;
  final String? password;
  final String? id;
  final String? name;
  final String? cellNo;
  final Place? place;
  final String? domain;
  final List<String>? tradeType;
  final String group;
  final String verified;

  const PartialUser({required this.email, this.password, this.id, this.domain, this.tradeType, this.name, this.cellNo, this.place, required this.group, required this.verified});

  PartialUser replace({
    String? email,
    String? password,
    String? id,
    String? name,
    String? cellNo,
    Place? place,
    String? domain,
    List<String>? tradeType,
    String? group,
    String? verified,
  }) {
    return PartialUser(
      email: email ?? this.email,
      password: password ?? this.password,
      id: id ?? this.id,
      name: name ?? this.name,
      cellNo: cellNo ?? this.cellNo,
      place: place ?? this.place,
      domain: domain ?? this.domain,
      tradeType: tradeType ?? this.tradeType,
      group: group ?? this.group,
      verified: verified ?? this.verified,
    );
  }
}
