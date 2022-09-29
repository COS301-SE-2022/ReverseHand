import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/models/list_users_model.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class ListUsersAction extends ReduxAction<AppState> {
  String group;

  ListUsersAction(this.group);

  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = '''query {
      listUsers(group: "$group") {
        users {
          email
          enabled
          status
          cognito_username
          id
        }
        next_token
      }
    }
  ''';

    final request = GraphQLRequest(document: graphQLDoc);
    try {
      final response = await Amplify.API.query(request: request).response;
      final data = jsonDecode(response.data)["listUsers"];
      return (group == "customer")
          ? state.copy(
              admin: state.admin.copy(
                adminManage: state.admin.adminManage.copy(
                  customers: ListUsersModel.fromJson(data, group),
                ),
              ),
            )
          : state.copy(
              admin: state.admin.copy(
                adminManage: state.admin.adminManage.copy(
                  tradesman: ListUsersModel.fromJson(data, group),
                ),
              ),
            );
    } on ApiException catch (e) {
      debugPrint(e.message);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  before() => dispatch(WaitAction.add("list_users"));

  @override
  after() => dispatch(WaitAction.remove("list_users"));
}
