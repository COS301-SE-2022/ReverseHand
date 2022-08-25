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
  final List<String> tradeTypes;
  final String userType;
  final bool? registered;
  final bool externalProvider; 
  final String? externalUsername; //for adding to user group, usernames different :(
  final String? scope; //for the admin user province scope

  const UserModel({
    required this.id,
    required this.email,
    this.name,
    this.cellNo,
    this.domains = const [],
    this.tradeTypes = const [],
    required this.userType,
    this.location,
    this.registered,
    required this.externalProvider,
    this.externalUsername,
    this.scope,
  });

  UserModel copy({
    String? id,
    String? email,
    String? name,
    String? cellNo,
    List<Domain>? domains,
    List<String>? tradeTypes,
    String? userType,
    Location? location,
    bool? registered,
    bool? externalProvider,
    String? externalUsername,
    String? scope,
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
      externalProvider: externalProvider ?? this.externalProvider,
      externalUsername: externalUsername ?? this.externalUsername,
      scope: scope ?? this.scope,
    );
  }
}
