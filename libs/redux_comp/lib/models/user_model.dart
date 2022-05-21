import 'package:flutter/material.dart';

@immutable
abstract class UserModel {
  final String _name;

  UserModel(this._name);

  String getName() {
    return _name;
  }
}
