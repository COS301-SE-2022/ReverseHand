import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/models/admin_user_model.dart';
import 'package:redux_comp/models/admin/app_management/models/list_users_model.dart';
import 'package:redux_comp/models/admin/app_management/report_model.dart';
import 'package:redux_comp/models/admin/reported_advert_model.dart';

@immutable
class AdminAppManageModel {
  final ListUsersModel? usersList;
  final AdminUserModel? activeUser;
  final List<ReportModel>? reviewReports;
  final List<ReportModel>? userReports;
  final List<ReportedAdvertModel>? advertReports;
  

  const AdminAppManageModel({
    this.usersList,
    this.activeUser,
    this.reviewReports,
    this.userReports,
    this.advertReports,
  });

  AdminAppManageModel copy({
   ListUsersModel? usersList,
   AdminUserModel? activeUser,
   List<ReportModel>? reviewReports,
   List<ReportModel>? userReports,
   List<ReportedAdvertModel>? advertReports
  }) {
    return AdminAppManageModel(
      usersList: usersList ?? this.usersList,
      activeUser: activeUser ?? this.activeUser,
      reviewReports: reviewReports ?? this.reviewReports,
      userReports: userReports ?? this.userReports,
      advertReports: advertReports ?? this.advertReports
    );
  }
}
