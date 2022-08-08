import 'package:flutter/material.dart';
import 'package:redux_comp/actions/user/login_action.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../../models/error_type_model.dart';

/* AddUserToGroupAction */
/* This action adds a user to a specified group if they have been verified on signup */

class AddUserToGroupAction extends ReduxAction<AppState> {

  final String username;
  final String group;

  AddUserToGroupAction(this.username, this.group);
  @override
  Future<AppState?> reduce() async {
    final String username = state.partialUser!.email;
    final String group = state.partialUser!.group;

    if (state.partialUser!.verified == "DONE") {
      String graphQLDoc = '''mutation  {
          addUserToGroup(email: "$username", group: "$group")
        }
        ''';
      final requestUserGroup = GraphQLRequest(
        document: graphQLDoc,
      );

      try {
        await Amplify.API.mutate(request: requestUserGroup).response;
        return null;
      } on ApiException catch (e) {
        debugPrint(e.message);
        return null;
      }
    } else {
      return state.copy(error: ErrorType.failedToAddUserToGroup);
    }
  }

  @override
  void after() async {
    await dispatch(
        LoginAction(state.partialUser!.email, state.partialUser!.password!));
  }
}
