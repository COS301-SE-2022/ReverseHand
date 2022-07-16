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
  final List<String>? domains;
  final List<String>? tradeTypes;
  final String group;
  final String verified;

  const PartialUser(
      {required this.email,
      this.password,
      this.id,
      this.domains,
      this.tradeTypes,
      this.name,
      this.cellNo,
      this.place,
      required this.group,
      required this.verified});

  PartialUser copy({
    String? email,
    String? password,
    String? id,
    String? name,
    String? cellNo,
    Place? place,
    List<String>? domains,
    List<String>? tradeTypes,
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
      domains: domains ?? this.domains,
      tradeTypes: tradeTypes ?? this.tradeTypes,
      group: group ?? this.group,
      verified: verified ?? this.verified,
    );
  }
}
