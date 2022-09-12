/* MODDEL TO STORE USER INFO PRIOR TO CONFIRMATION */

import 'package:flutter/material.dart';

@immutable
class ReportedUserModel {
  final String id;
  final String email;
  final String name;
  final String cellNo;

  const ReportedUserModel(
      {required this.id,
      required this.email,
      required this.name,
      required this.cellNo});

  ReportedUserModel copy({
    String? id,
    String? email,
    String? name,
    String? cellNo,
  }) {
    return ReportedUserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      cellNo: cellNo ?? this.cellNo,
    );
  }

  factory ReportedUserModel.fromJson(obj) {
    return ReportedUserModel(
      id: obj['id'],
      email: obj['email'],
      name: obj['name'],
      cellNo: obj['cellNo'],
    );
  }
}
