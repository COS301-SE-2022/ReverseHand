import 'package:flutter/material.dart';

@immutable
class UserModel {
  final String _id;
  final String _email;
  final String _userType;

  const UserModel(this._id, this._email, this._userType);

  String getId() {
    return _id;
  }

  String getEmail() {
    return _email;
  }

  String getUserType() {
    return _userType;
  }

   UserModel replace({
    String? id,
    String? email,
    String? confirmed,
  }) {
    return UserModel(
      id ?? getId(),
      email ?? getEmail(),
      confirmed ?? getUserType(),
    );
  }
}
