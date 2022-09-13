import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/models/cognito_user_model.dart';
import 'package:redux_comp/models/admin/reported_user_model.dart';

@immutable
class AdminActiveUserModel {
  final ReportedUserModel dbModel;
  final CognitoUserModel cogUser;

  const AdminActiveUserModel({
    required this.dbModel,
    required this.cogUser,
  });

  AdminActiveUserModel copy({
    ReportedUserModel? dbModel,
    CognitoUserModel? cogUser,
  }) {
    return AdminActiveUserModel(
      dbModel: dbModel ?? this.dbModel,
      cogUser: cogUser ?? this.cogUser,
    );
  }
}
