/* MODDEL TO STORE USER INFO PRIOR TO CONFIRMATION */

import 'package:flutter/material.dart';

@immutable
class PartialUser {
  final String email;
  final String password;
  final String verified;

  const PartialUser(this.email, this.password, this.verified);

  PartialUser replace({
    String? email,
    String? password,
    String? verified,
  }) {
    return PartialUser(
      email ?? this.email,
      password ?? this.password,
      verified ?? this.verified,
    );
  }
}
