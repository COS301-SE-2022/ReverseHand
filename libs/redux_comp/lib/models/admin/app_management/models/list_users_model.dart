import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/models/cognito_user_model.dart';

@immutable
class ListUsersModel {
  final List<CognitoUserModel> users;
  final String? nextToken;
  final String? group;

  const ListUsersModel({
    required this.users,
    this.group,
    this.nextToken,
  });

  ListUsersModel copy({
    List<CognitoUserModel>? users,
    String? nextToken,
    String? group,
  }) {
    return ListUsersModel(
      users: users ?? this.users,
      group: group ?? this.group,
      nextToken: nextToken ?? this.nextToken,
    );
  }

  factory ListUsersModel.fromJson(obj, group) {
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
            group: group
          )
        : ListUsersModel(
            users: userList,
            group: group
          );
  }
}
