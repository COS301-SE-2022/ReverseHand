import 'package:flutter/material.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';
import 'package:redux_comp/models/review_model.dart';
import 'package:redux_comp/models/user_models/statistics_model.dart';

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
  final String?
      externalUsername; //for adding to user group, usernames different :(
  final String? scope; //for the admin user province scope
  final StatisticsModel statistics;
  final String? profileImage;
  final List<ReviewModel> reviews;

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
    required this.statistics,
    this.profileImage,
    required this.reviews,
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
    StatisticsModel? statistics,
    String? profileImage,
    List<ReviewModel>? reviews,
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
      statistics: statistics ?? this.statistics,
      profileImage: profileImage ?? this.profileImage,
      reviews: reviews ?? this.reviews,
    );
  }

  // implementing hashcode
  @override
  int get hashCode => Object.hash(
        id,
        email,
        name,
        cellNo,
        domains,
        location,
        registered,
        externalProvider,
        externalUsername,
        scope,
        statistics,
        profileImage,
      );

  @override
  bool operator ==(Object other) {
    return other is UserModel &&
        id == other.id &&
        email == other.email &&
        name == other.name &&
        cellNo == other.cellNo &&
        domains == other.domains &&
        location == other.location &&
        registered == other.registered &&
        externalProvider == other.externalProvider &&
        externalUsername == other.externalUsername &&
        scope == other.scope &&
        statistics == other.statistics &&
        profileImage == other.profileImage;
  }
}
