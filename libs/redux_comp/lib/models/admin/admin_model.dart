/* MODDEL TO STORE USER INFO PRIOR TO CONFIRMATION */

import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/reported_advert_model.dart';
import 'package:redux_comp/models/admin/reported_user_model.dart';

@immutable
class AdminModel {
  final List<ReportedUserModel> reportedCustomers;
  final ReportedUserModel? activeUser;
  final List<ReportedAdvertModel>? activeAdverts;


  const AdminModel(
      {required this.reportedCustomers, this.activeUser, this.activeAdverts});

  AdminModel copy({
    List<ReportedUserModel>? reportedCustomers,
    ReportedUserModel? activeUser,
    List<ReportedAdvertModel>? activeAdverts,
  }) {
    return AdminModel(
      reportedCustomers: reportedCustomers ?? this.reportedCustomers,
      activeUser: activeUser ?? this.activeUser,
      activeAdverts: activeAdverts ?? this.activeAdverts,
    );
  }
}
