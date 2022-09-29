import 'package:flutter/material.dart';

@immutable
class CognitoUserModel {
  final String id;
  final String email;
  final bool enabled;
  final String userType;
  final String status;
  final String cognitoUsername;

  const CognitoUserModel({
    required this.id,
    required this.email,
    required this.userType,
    required this.enabled,
    required this.status,
    required this.cognitoUsername,
  });

  CognitoUserModel copy({
    String? id,
    String? email,
    String? userType,
    bool? enabled,
    String? status,
    String? cognitoUsername,
  }) {
    return CognitoUserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      enabled: enabled ?? this.enabled,
      status: status ?? this.status,
      cognitoUsername: cognitoUsername ?? this.cognitoUsername,
    );
  }

  factory CognitoUserModel.fromJson(obj, type) {
    return CognitoUserModel(
      id: obj['id'],
      email: obj['email'],
      userType: type,
      status: obj['status'],
      cognitoUsername: obj['cognito_username'],
      enabled: obj['enabled'] == "true",
    );
  }

  @override
  operator ==(Object other) =>
      other is CognitoUserModel &&
      id == other.id &&
      email == other.email &&
      userType == other.userType &&
      enabled == other.enabled &&
      status == other.status &&
      cognitoUsername == other.cognitoUsername;

  @override
  int get hashCode => Object.hash(
        id,
        email,
        userType,
        enabled,
        status,
        cognitoUsername,
      );
}
