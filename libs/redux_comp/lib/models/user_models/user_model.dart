import 'package:flutter/material.dart';

@immutable
class UserModel {
  final String _id;
  final String _email;
  final String _confirmed;

  const UserModel(this._id, this._email, this._confirmed);

  String getId() {
    return _id;
  }

  String getEmail() {
    return _email;
  }

  String getConfirmed() {
    return _confirmed;
  }

   UserModel replace({
    String? id,
    String? email,
    String? confirmed,
  }) {
    return UserModel(
      id ?? getId(),
      email ?? getEmail(),
      confirmed ?? getConfirmed(),
    );
  }
}
