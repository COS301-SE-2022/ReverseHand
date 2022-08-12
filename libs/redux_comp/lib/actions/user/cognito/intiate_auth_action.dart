import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:redux_comp/actions/user/user_table/check_user_exists_action.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/models/user_models/cognito_auth_model.dart';
import 'package:redux_comp/models/user_models/user_model.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class IntiateAuthAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    Amplify.Auth.signOut();
    final authSession = await Amplify.Auth.fetchAuthSession();
    if (authSession.isSignedIn == true) {
      final authSessionWithCredentials = (await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true),
      )) as CognitoAuthSession;

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
      Map<String, dynamic> payload =
          Jwt.parseJwt(authSessionWithCredentials.userPoolTokens!.accessToken);
      final AWSCognitoUserPoolTokens? tokens =
          authSessionWithCredentials.userPoolTokens;

      List<String>? groups = List<String>.from(
          (payload["cognito:groups"] == null)
              ? []
              : payload["cognito:groups"]!);
      if (state.userDetails!.userType == "" && groups.isEmpty) {
        return state.copy(
            authModel: CognitoAuthModel(
              accessToken: tokens!.accessToken,
              refreshToken: tokens.refreshToken,
            ),
            userDetails: state.userDetails!.copy(id: id, email: email),
            error: ErrorType.userNotInGroup);
      }

      String userType = "";
      if (state.userDetails!.userType == "" && groups.isNotEmpty) {
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
            error: ErrorType.none,
            userDetails: UserModel(id: id, email: email, userType: userType));
      } else {
        return state.copy(
          error: ErrorType.none,
          userDetails: state.userDetails!.copy(
            id: (state.userDetails!.userType == "Tradesman")
                ? "t#$id"
                : "c#$id",
            email: email,
            userType: state.userDetails!.userType,
          ),
        );
      }
    } else {
      // dispatch(NavigateAction.pushNamed("/"));
      return state.copy(error: ErrorType.userNotAuthorised);
    }
  }

  @override
  void after() {
    if (state.error == ErrorType.none) {
      dispatch(CheckUserExistsAction());
      // dispatch(SubscribMessagesAction());
    } else if (state.error == ErrorType.userNotInGroup) {
      dispatch(WaitAction.remove("flag"));
      dispatch(NavigateAction.pushNamed('/usertype_selection'));
    }
    state.copy(error: ErrorType.none);
  }
}
