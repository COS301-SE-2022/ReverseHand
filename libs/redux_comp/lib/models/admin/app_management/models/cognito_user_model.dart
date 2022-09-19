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

  factory CognitoUserModel.fromJson(obj) {
 

    return CognitoUserModel(
      id: obj['id'],
      email: obj['email'],
      status: obj['status'],
      enabled: obj['enabled'] == "true",
    );
  }
}