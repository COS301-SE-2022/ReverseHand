import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/models/cognito_user_model.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class EnableUserAction extends ReduxAction<AppState> {
  final String username;
  final bool disable;
  final CognitoUserModel? user;
  EnableUserAction({required this.username, required this.disable, this.user});

  @override
  Future<AppState?> reduce() async {
    String graphQLDoc = '''mutation {
      enableUser(disable: $disable, username: "$username")
    }''';

    final request = GraphQLRequest(document: graphQLDoc);
    try {
      await Amplify.API.query(request: request).response;
      if (user != null) {
        List<CognitoUserModel> users;
        if (user!.userType == "customer") {
          users = state.admin.adminManage.customers?.copy().users ?? [];
          users[users.indexOf(user!)] = user!.copy(enabled: (disable) ? false : true);

          return state.copy(
            admin: state.admin.copy(
              adminManage: state.admin.adminManage.copy(
                customers: state.admin.adminManage.customers!.copy(
                  users: users,
                ),
              ),
            ),
          );
        } else {
          users = state.admin.adminManage.tradesman?.copy().users ?? [];
          users[users.indexOf(user!)] = user!.copy(enabled: (disable) ? false : true);

          return state.copy(
            admin: state.admin.copy(
              adminManage: state.admin.adminManage.copy(
                customers: state.admin.adminManage.customers!.copy(
                  users: users,
                ),
              ),
            ),
          );
        }
      } else {
        return state.copy(
          admin: state.admin.copy(
            adminManage: state.admin.adminManage.copy(
              activeUser: state.admin.adminManage.activeUser!
                  .copy(enabled: (disable) ? false : true),
            ),
          ),
        );
      }
    } on ApiException catch (e) {
      debugPrint(e.message);
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  void before() => dispatch(WaitAction.add("enable_user"));

  @override
  void after() => dispatch(WaitAction.remove("enable_user"));
}
