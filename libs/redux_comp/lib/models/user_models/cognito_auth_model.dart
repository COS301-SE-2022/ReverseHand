/* MODDEL TO STORE USER INFO PRIOR TO CONFIRMATION */

import 'package:flutter/material.dart';

@immutable
class CognitoAuthModel {
  final String id;
  final List<String> groups;
  final bool isSignedIn;

  const CognitoAuthModel(
      {required this.id,
      required this.groups,
      required this.isSignedIn});

  CognitoAuthModel copy({
    String? id,
    List<String>? groups,
    bool? isSignedIn,
  }) {
    return CognitoAuthModel(
      id: id ?? this.id,
      groups: groups ?? this.groups,
      isSignedIn: isSignedIn ?? this.isSignedIn,
    );
  }
}
