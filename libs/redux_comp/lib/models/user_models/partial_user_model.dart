/* MODDEL TO STORE USER INFO PRIOR TO CONFIRMATION */

import 'package:flutter/material.dart';

@immutable
class PartialUser {
  final String email;
  final String? password;
  final String group;
  final String verified;

  const PartialUser({required this.email, this.password, required this.group, required this.verified});

  PartialUser replace({
    String? email,
    String? password,
    String? group,
    String? verified,
  }) {
    return PartialUser(
      email: email ?? this.email,
      password: password ?? this.password,
      group: group ?? this.group,
      verified: verified ?? this.verified,
    );
  }
}
