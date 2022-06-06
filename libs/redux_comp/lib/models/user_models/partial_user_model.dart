/* MODDEL TO STORE USER INFO PRIOR TO CONFIRMATION */

import 'package:flutter/material.dart';

@immutable
class PartialUser {
  final String _email;
  final String _password;
  final String _confirmed;

  const PartialUser(this._email, this._password, this._confirmed);

  String getEmail() {
    return _email;
  }

  String getPassword() {
    return _password;
  }

  String getConfirmed() {
    return _confirmed;
  }

  PartialUser replace({
    String? email,
    String? password,
    String? confirmed,
  }) {
    return PartialUser(
      email ?? getEmail(),
      password ?? getPassword(),
      confirmed ?? getConfirmed(),
    );
  }
}
