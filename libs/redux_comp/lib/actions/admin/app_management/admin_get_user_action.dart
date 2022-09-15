import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/models/admin_user_model.dart';
import '../../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class AdminGetUserAction extends ReduxAction<AppState> {
  final String userId;

  AdminGetUserAction(this.userId);

  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = '''query {
      adminGetUser(user_id: "$userId") {
        id
        name
        warnings
        email
        cognito_username
        enabled
      }
    }
  ''';

    final request = GraphQLRequest(document: graphQLDoc);
    try {
      final response = await Amplify.API.query(request: request).response;
      final data = jsonDecode(response.data)["adminGetUser"];

      return state.copy(
        admin: state.admin.copy(
          adminManage: state.admin.adminManage.copy(
            activeUser: AdminUserModel.fromJson(data),
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
  void before() => dispatch(WaitAction.add("admin_get_user"));

  @override
  void after() => dispatch(WaitAction.remove("admin_get_user"));
}

// query {
//    adminGetUser(user_id: c#983b506a-8ac3-4ca0-9844-79ed15291cd5) {
//      id
//      name
//      warnings
//      email
//      cognito_username
//      enabled
//    }
//  }