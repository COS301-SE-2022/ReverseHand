
import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';

@immutable
class UserModel {
  final String id;
  final String? email;
  final String? name;
  final String? cellNo;
  final Location? location;
  final List<dynamic>? domains;
  final List<dynamic>? tradeTypes;
  final String userType;

  const UserModel({
    required this.id,
    this.email,
    this.name,
    this.cellNo,
    this.domains,
    this.tradeTypes,
    required this.userType,
    this.location,
  });

  UserModel replace({
    String? id,
    String? email,
    String? name,
    String? cellNo,
    List<dynamic>? domains,
    List<dynamic>? tradeTypes,
    String? userType,
    Location? location,
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
    );
  }
}
