import 'package:flutter/material.dart';

@immutable
class CognitoUserModel {
  final String id;
  final String email;
  final bool enabled;
  final String status;

  const CognitoUserModel({
    required this.id,
    required this.email,
    required this.enabled,
    required this.status,
  });

  CognitoUserModel copy({
    String? id,
    String? email,
    bool? enabled,
    String? status,
  }) {
    return CognitoUserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      enabled: enabled ?? this.enabled,
      status: status ?? this.status,
    );
  }

  factory CognitoUserModel.fromJson(obj) {
    return CognitoUserModel(
      id: obj['id'],
      email: obj['email'],
      status: obj['status'],
      enabled: obj['enabled'] == "true",
    );
  }
}
