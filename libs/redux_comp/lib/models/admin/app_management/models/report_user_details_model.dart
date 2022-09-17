import 'package:flutter/material.dart';

@immutable
class ReportUserDetailsModel {
  final String id;
  final String name;

  const ReportUserDetailsModel({
    required this.id,
    required this.name,
  });

   factory ReportUserDetailsModel.fromJson(obj) {
    return ReportUserDetailsModel(
      id: obj['id'] ?? "",
      name: obj['name'] ?? "",
    );
  }
}
