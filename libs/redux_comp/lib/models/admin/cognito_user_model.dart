import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/report_model.dart';

@immutable
class CognitoUserModel {
  final String id;
  final String email;
  final bool enabled;
 

  const CognitoUserModel({
    required this.id,
    required this.email,
    required this.enabled,
  });

  factory CognitoUserModel.fromJson(obj) {
 

    return CognitoUserModel(
      id: obj['id'],
      email: obj['email'],
      enabled: obj['enabled'],
    );
  }
}