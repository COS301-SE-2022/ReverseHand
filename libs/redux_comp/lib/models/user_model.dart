import 'package:flutter/material.dart';

@immutable
abstract class UserModel {
  final String _name;
  final String _email;

  UserModel(this._name, this._email);

  String getName() {
    return _name;
  }

  String getEmail() {
    return _name;
  }
}
