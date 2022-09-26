import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/models/admin_user_model.dart';
import 'package:redux_comp/models/admin/app_management/models/list_users_model.dart';
import 'package:redux_comp/models/admin/app_management/report_model.dart';
import 'package:redux_comp/models/admin/app_management/reported_advert_model.dart';

@immutable
class AdminAppManageModel {
  final ListUsersModel? customers;
  final ListUsersModel? tradesman;
  final AdminUserModel? activeUser;
  final List<ReportModel>? reviewReports;
  final List<ReportModel>? userReports;
  final List<ReportedAdvertModel>? advertReports;
  

  const AdminAppManageModel({
    this.customers,
    this.tradesman,
    this.activeUser,
    this.reviewReports,
    this.userReports,
    this.advertReports,
  });

  AdminAppManageModel copy({
   ListUsersModel? customers,
   ListUsersModel? tradesman,
   AdminUserModel? activeUser,
   List<ReportModel>? reviewReports,
   List<ReportModel>? userReports,
   List<ReportedAdvertModel>? advertReports
  }) {
    return AdminAppManageModel(
      customers: customers ?? this.customers,
      tradesman: tradesman ?? this.tradesman,
      activeUser: activeUser ?? this.activeUser,
      reviewReports: reviewReports ?? this.reviewReports,
      userReports: userReports ?? this.userReports,
      advertReports: advertReports ?? this.advertReports
    );
  }
}
