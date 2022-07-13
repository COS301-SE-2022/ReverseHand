import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

import '../../models/error_type_model.dart';

class AddUserToGroupAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    final String username = state.partialUser!.email;
    final String group = state.partialUser!.group;

    if (state.partialUser!.verified == "DONE") {
      /* If the user is verified then the signUpStep is DONE, so we just update the partial user model and add the user to the correct group*/
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
      return state.replace(
        error: ErrorType.failedToAddUserToGroup
      );
    }
  }
}
