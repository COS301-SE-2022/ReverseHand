import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/models/cognito_user_model.dart';
import 'package:redux_comp/models/admin/app_management/models/report_model.dart';
import 'package:redux_comp/models/admin/reported_advert_model.dart';

@immutable
class AdminAppManageModel {
  final List<CognitoUserModel>? usersList;
  final List<ReportModel>? reviewReports;
  final List<ReportModel>? userReports;
  final List<ReportedAdvertModel>? advertReports;
  

  const AdminAppManageModel({
    this.usersList,
    this.reviewReports,
    this.userReports,
    this.advertReports
  });

  AdminAppManageModel copy({
   List<CognitoUserModel>? usersList,
   List<ReportModel>? reviewReports,
   List<ReportModel>? userReports,
   List<ReportedAdvertModel>? advertReports
  }) {
    return AdminAppManageModel(
      usersList: usersList ?? this.usersList,
      reviewReports: reviewReports ?? this.reviewReports,
      userReports: userReports ?? this.userReports,
      advertReports: advertReports ?? this.advertReports
    );
  }
}
