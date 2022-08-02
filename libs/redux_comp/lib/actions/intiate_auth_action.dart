import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:redux_comp/actions/user/check_user_exists_action.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/models/user_models/cognito_auth_model.dart';
import 'package:redux_comp/models/user_models/user_model.dart';

import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class IntiateAuthAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    // Amplify.Auth.signOut();
    final authSession = await Amplify.Auth.fetchAuthSession();
    if (authSession.isSignedIn == true) {
      final authSessionWithCredentials = (await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true),
      )) as CognitoAuthSession;

      final userAttr = await Amplify.Auth.fetchUserAttributes();
      String email = "";
      for (AuthUserAttribute attr in userAttr) {
        if (attr.userAttributeKey.key == "email") {
          email = attr.value;
        }
      }
      Map<String, dynamic> payload =
          Jwt.parseJwt(authSessionWithCredentials.userPoolTokens!.accessToken);

      String id = payload["sub"];
      //the await does not seem necessary but this line causes an ad hoc registration error

      List<String> groups = List<String>.from(payload["cognito:groups"]);

      String userType = "";
      if (groups.contains("customer")) {
        userType = "Consumer";
        id = "c#$id";
      } else if (groups.contains("tradesman")) {
        userType = "Tradesman";
        id = "t#$id";
      } else {
        return state.copy(error: ErrorType.userNotInGroup);
      }

      return state.copy(
          userDetails: UserModel(id: id, email: email, userType: userType));
    } else {
      dispatch(NavigateAction.pushNamed("/"));
      return null;
    }
  }

  @override
  void after() {
    if (state.error == ErrorType.none) {
      dispatch(CheckUserExistsAction());
    } else if (state.error == ErrorType.userNotInGroup) {
      // dispatch(NavigateAction.pushNamed('/'));
    }
  }
}
