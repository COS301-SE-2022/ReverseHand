import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/models/cognito_user_model.dart';
import 'package:redux_comp/models/admin/app_management/models/list_users_model.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class AdminSearchUserAction extends ReduxAction<AppState> {
  final String email;
  final String group;
  AdminSearchUserAction({required this.email, required this.group});

  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = '''query MyQuery {
      adminSearchUser(email: "$email", group: "$group") {
        id
        email
        status
        enabled
      }
    }
    ''';

    final request = GraphQLRequest(document: graphQLDoc);
    try {
      final response = await Amplify.API.query(request: request).response;
      final data = jsonDecode(response.data)["adminSearchUser"];

      List<CognitoUserModel> result = [];
      for (var user in data) {
        result.add(CognitoUserModel.fromJson(user));
      }

      return (group == "customer")
          ? state.copy(
              admin: state.admin.copy(
                adminManage: state.admin.adminManage.copy(
                    customers: ListUsersModel(users: result, group: group)),
              ),
            )
          : state.copy(
              admin: state.admin.copy(
                adminManage: state.admin.adminManage.copy(
                    tradesman: ListUsersModel(users: result, group: group)),
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
