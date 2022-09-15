/* MODDEL TO STORE USER INFO PRIOR TO CONFIRMATION */

import 'package:flutter/material.dart';

@immutable
class ResetPasswordModel {
  final String email;
  final String? otp;
  final String? verified;

  const ResetPasswordModel(
      {required this.email,
      this.otp,
      this.verified});

  ResetPasswordModel copy({
    String? email,
    String? otp,
    String? verified,
  }) {
    return ResetPasswordModel(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      verified: verified ?? this.verified,
    );
  }
}
