import 'package:flutter/material.dart';

@immutable
abstract class UserModel {
  final String _id;
  final String _name;
  final String _email;

  const UserModel(this._id, this._name, this._email);

  String getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  String getEmail() {
    return _email;
  }

  UserModel replace();
}
