import 'package:flutter/material.dart';

@immutable
class UserModel {
  final String id;
  final String email;
  final String userType;

  const UserModel(this.id, this.email, this.userType);

  String getId() {
    return id;
  }

  String getEmail() {
    return email;
  }

  String getUserType() {
    return userType;
  }

   UserModel replace({
    String? id,
    String? email,
    String? userType,
  }) {
    return UserModel(
      id ?? this.id,
      email ?? this.email,
      userType ?? this.userType,
    );
  }
}
