import 'package:flutter/material.dart';
import 'package:redux_comp/actions/user/user_table/check_user_exists_action.dart';
import 'package:redux_comp/models/error_type_model.dart';
import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../../chat/subscribe_messages_action.dart';

class GetCognitoUserAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    final userAttr = await Amplify.Auth.fetchUserAttributes();

    String email = "", id = "";
    for (AuthUserAttribute attr in userAttr) {
      switch (attr.userAttributeKey.key) {
        case "email":
          email = attr.value;
          break;
        case "sub":
          id = attr.value;
          break;
      }
    }
    return state.copy(
        error: ErrorType.none,
        userDetails: state.userDetails!.copy(
            id: (state.userDetails!.userType == "Consumer") ? "c#$id" : "t#$id",
            email: email));
  }

  @override
  Future<void> after() async {
    if (state.error == ErrorType.none && state.userDetails!.userType != "Admin") {
      dispatch(CheckUserExistsAction());
      dispatch(SubscribMessagesAction());
    } else if (state.error == ErrorType.none && state.userDetails!.userType == "Admin") {
      dispatch(NavigateAction.pushNamed("/admin_listings"));
    } else {
      debugPrint("Confused as to how we got stuck in actions/user/cognito/get_cog_user");
    }
  }
}
