import 'package:flutter/material.dart';

@immutable
class AdminUserModel {
  final String id;
  final String name;
  final int warnings;
  final String email;
  final String cognitoUsername;
  final bool enabled;

  const AdminUserModel({
    required this.id,
    required this.name,
    required this.warnings,
    required this.email,
    required this.cognitoUsername,
    required this.enabled,
  });

  AdminUserModel copy({
    String? id,
    String? name,
    int? warnings,
    String? email,
    String? cognitoUsername,
    bool? enabled,
  }) {
    return AdminUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      warnings: warnings ?? this.warnings,
      email: email ?? this.email,
      cognitoUsername: cognitoUsername ?? this.cognitoUsername,
      enabled: enabled ?? this.enabled,
    );
  }

  factory AdminUserModel.fromJson(obj) {
    return AdminUserModel(
      id: obj['id'],
      name: obj['name'],
      warnings: obj['warnings'],
      email: obj['email'],
      cognitoUsername: obj['cognito_username'],
      enabled: obj['enabled'],
    );
  }
}
