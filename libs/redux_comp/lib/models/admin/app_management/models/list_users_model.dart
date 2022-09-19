import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/models/cognito_user_model.dart';

@immutable
class ListUsersModel {
  final List<CognitoUserModel> users;
  final String? nextToken;

  const ListUsersModel({
    required this.users,
    this.nextToken,
  });

  factory ListUsersModel.fromJson(obj) {
    List<CognitoUserModel> userList = [];
    obj["users"].forEach(
      (user) => userList.add(
        CognitoUserModel.fromJson(user),
      ),
    );

    return (obj['next_token'] != null)
        ? ListUsersModel(
            users: userList,
            nextToken: obj['next_token'],
          )
        : ListUsersModel(
            users: userList,
          );
  }
}
