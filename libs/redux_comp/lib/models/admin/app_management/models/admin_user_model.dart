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

  factory AdminUserModel.fromJson(obj) {
    return AdminUserModel(
      id: obj['id'],
      name: obj['name'],
      warnings:  obj['warnings'],
      email: obj['email'],
      cognitoUsername: obj['cognito_username'],
      enabled: obj['enabled'],
    );
  }
}
