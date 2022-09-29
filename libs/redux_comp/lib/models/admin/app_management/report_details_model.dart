import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/models/report_user_details_model.dart';

@immutable
class ReportDetailsModel {
  final String description;
  final String reason;
  final ReportUserDetailsModel? reportedUser;
  final ReportUserDetailsModel? reporterUser;

  const ReportDetailsModel({
    required this.description,
    required this.reason,
    this.reportedUser,
    this.reporterUser,
  });

  factory ReportDetailsModel.fromJson(obj) {
    if (obj['reported_user'] != null) {
      return ReportDetailsModel(
        description: obj['description'],
        reason: obj['reason'],
        reporterUser: ReportUserDetailsModel.fromJson(obj['reporter_user']),
        reportedUser: ReportUserDetailsModel.fromJson(obj['reported_user']),
      );
    } else {
      return ReportDetailsModel(
        description: obj['description'],
        reason: obj['reason'],
        reporterUser: ReportUserDetailsModel.fromJson(obj['reporter_user']),
      );
    }
  }

  String toJson(bool reported) {
    return (reported == true)
        ? """{
      reason: "$reason",
      description: "$description",
      reported_user: {
        id: "${reportedUser!.id}",
        name: "${reportedUser!.name}",
      }
    }"""
        : """{
      reason: "$reason",
      description: "$description",
      reporter_user: {
        id: "${reporterUser!.id}",
        name: "${reporterUser!.name}",
      }
    }""";
  }

  @override
  operator ==(Object other) =>
      other is ReportDetailsModel &&
      reason == other.reason &&
      description == other.description &&
      reportedUser == other.reportedUser &&
      reporterUser == other.reporterUser;

  @override
  int get hashCode => Object.hash(
        reason,
        description,
        reportedUser,
        reporterUser,
      );
}
