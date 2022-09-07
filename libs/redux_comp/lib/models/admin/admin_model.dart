/* MODDEL TO STORE USER INFO PRIOR TO CONFIRMATION */

import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/cognito_user_model.dart';
import 'package:redux_comp/models/admin/reported_advert_model.dart';
import 'package:redux_comp/models/admin/reported_user_model.dart';

@immutable
class AdminModel {
  final List<ReportedUserModel> reportedCustomers;
  final ReportedUserModel? activeUser;
  final List<ReportedAdvertModel>? activeAdverts;
  final List<ReportedUserModel>? activeUsers;
  final List<CognitoUserModel>? activeCognitoUsers;
  final ReportedAdvertModel? activeAdvert;
  final String? pagenationToken;


  const AdminModel(
      {required this.reportedCustomers, this.activeUser, this.activeUsers, this.activeCognitoUsers , this.activeAdverts, this.activeAdvert, this.pagenationToken});

  AdminModel copy({
    List<ReportedUserModel>? reportedCustomers,
    ReportedUserModel? activeUser,
    List<ReportedUserModel>? activeUsers,
    List<CognitoUserModel>? activeCognitoUsers,
    List<ReportedAdvertModel>? activeAdverts,
    ReportedAdvertModel? activeAdvert,
    String? pagenationToken,
  }) {
    return AdminModel(
      reportedCustomers: reportedCustomers ?? this.reportedCustomers,
      activeUser: activeUser ?? this.activeUser,
      activeUsers: activeUsers ?? this.activeUsers,
      activeCognitoUsers: activeCognitoUsers ?? this.activeCognitoUsers,
      activeAdverts: activeAdverts ?? this.activeAdverts,
      activeAdvert: activeAdvert ?? this.activeAdvert,
      pagenationToken: pagenationToken ?? this.pagenationToken,
    );
  }
}
