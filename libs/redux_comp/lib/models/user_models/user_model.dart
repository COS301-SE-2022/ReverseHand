import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';

import '../geolocation/domain_model.dart';

@immutable
class UserModel {
  final String id;
  final String email;
  final String? name;
  final String? cellNo;
  final Location? location;
  final List<Domain> domains;
  final List<dynamic>? tradeTypes;
  final String userType;
  final bool? registered;

  const UserModel({
    required this.id,
    required this.email,
    this.name,
    this.cellNo,
    this.domains = const [],
    this.tradeTypes,
    required this.userType,
    this.location,
    this.registered,
  });

  UserModel copy({
    String? id,
    String? email,
    String? name,
    String? cellNo,
    List<Domain>? domains,
    List<dynamic>? tradeTypes,
    String? userType,
    Location? location,
    bool? registered,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      cellNo: cellNo ?? this.cellNo,
      domains: domains ?? this.domains,
      tradeTypes: tradeTypes ?? this.tradeTypes,
      userType: userType ?? this.userType,
      location: location ?? this.location,
      registered: registered ?? this.registered,
    );
  }
}
