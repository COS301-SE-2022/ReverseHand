/* MODDEL TO STORE USER INFO PRIOR TO CONFIRMATION */

import 'package:flutter/material.dart';

@immutable
class PartialUser {

  final String _email; 
  final String _confirmed;

  const PartialUser(this._email, this._confirmed);

  String getEmail() { return _email;  }
  String getConfirmed() { return _confirmed;  }

  PartialUser replace({
    String? email,
    String? confirmed,
  }) {
    return PartialUser(
      email ?? getEmail(),
      confirmed ?? getConfirmed(),
    );
  }
}
