/* MODDEL TO STORE USER INFO PRIOR TO CONFIRMATION */

import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/admin_app_manage_model.dart';
import 'package:redux_comp/models/admin/app_metrics/app_metrics_model.dart';

@immutable
class AdminModel {
  final AdminAppManageModel adminManage;
  final AppMetricsModel appMetrics;

  const AdminModel({
    required this.adminManage,
    required this.appMetrics
  });

  AdminModel copy({
    AdminAppManageModel? adminManage,
    AppMetricsModel? appMetrics
  }) {
    return AdminModel(
      adminManage: adminManage ?? this.adminManage,
      appMetrics: appMetrics ?? this.appMetrics
    );
  }
}

// @immutable
// class AdminModel {
//   final List<ReportedUserModel> reportedCustomers;
//   final ReportedUserModel? activeUser;
//   final List<ReportedAdvertModel>? activeAdverts;
//   final List<ReportedUserModel>? activeUsers;
//   final List<CognitoUserModel>? activeCognitoUsers;
//   final ReportedAdvertModel? activeAdvert;
//   final String? pagenationToken;
//   final Image? dash;

//   const AdminModel({
//     required this.reportedCustomers,
//     this.activeUser,
//     this.activeUsers,
//     this.activeCognitoUsers,
//     this.activeAdverts,
//     this.activeAdvert,
//     this.pagenationToken,
//     this.dash,
//   });

//   AdminModel copy({
//     List<ReportedUserModel>? reportedCustomers,
//     ReportedUserModel? activeUser,
//     List<ReportedUserModel>? activeUsers,
//     List<CognitoUserModel>? activeCognitoUsers,
//     List<ReportedAdvertModel>? activeAdverts,
//     ReportedAdvertModel? activeAdvert,
//     String? pagenationToken,
//     Image? dash,
//   }) {
//     return AdminModel(
//       reportedCustomers: reportedCustomers ?? this.reportedCustomers,
//       activeUser: activeUser ?? this.activeUser,
//       activeUsers: activeUsers ?? this.activeUsers,
//       activeCognitoUsers: activeCognitoUsers ?? this.activeCognitoUsers,
//       activeAdverts: activeAdverts ?? this.activeAdverts,
//       activeAdvert: activeAdvert ?? this.activeAdvert,
//       pagenationToken: pagenationToken ?? this.pagenationToken,
//       dash: dash ?? this.dash,
//     );
//   }
// }

