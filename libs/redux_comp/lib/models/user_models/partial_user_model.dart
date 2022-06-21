/* MODDEL TO STORE USER INFO PRIOR TO CONFIRMATION */

import 'package:flutter/material.dart';

@immutable
class PartialUser {
  final String email;
  final String group;
  final String verified;

  const PartialUser(this.email, this.group, this.verified);

  PartialUser replace({
    String? email,
    String? group,
    String? verified,
  }) {
    return PartialUser(
      email ?? this.email,
      group ?? this.group,
      verified ?? this.verified,
    );
  }
}
