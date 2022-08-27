/* MODDEL TO STORE USER INFO PRIOR TO CONFIRMATION */

import 'package:flutter/material.dart';

@immutable
class CognitoAuthModel {
  final String accessToken;
  final String refreshToken;

  const CognitoAuthModel({
    required this.accessToken,
    required this.refreshToken,
  });

  CognitoAuthModel copy({
    String? accessToken,
    String? refreshToken,
  }) {
    return CognitoAuthModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
