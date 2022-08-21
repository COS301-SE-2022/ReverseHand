/* MODDEL TO STORE USER INFO PRIOR TO CONFIRMATION */

import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/reported_user_model.dart';

@immutable
class AdminModel {
  final List<ReportedUserModel> reportedCustomers;


  const AdminModel(
      {required this.reportedCustomers});

  AdminModel copy({
    List<ReportedUserModel>? reportedCustomers,
  }) {
    return AdminModel(
      reportedCustomers: reportedCustomers ?? this.reportedCustomers,
    );
  }
}
