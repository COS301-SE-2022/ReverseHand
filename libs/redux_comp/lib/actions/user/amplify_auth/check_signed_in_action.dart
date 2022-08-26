import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:redux_comp/actions/user/cognito/assign_groups_action.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/models/user_models/cognito_auth_model.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class CheckSignedInAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    // Amplify.Auth.signOut();
    final authSession = await Amplify.Auth.fetchAuthSession();
    if (authSession.isSignedIn == true) {
      final authSessionWithCredentials = (await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true),
      )) as CognitoAuthSession;

      final AWSCognitoUserPoolTokens tokens =
          authSessionWithCredentials.userPoolTokens!;

      return state.copy(
          authModel: CognitoAuthModel(
              refreshToken: tokens.refreshToken,
              accessToken: tokens.accessToken));
    } else {
      return state.copy(error: ErrorType.userNotAuthorised);
    }
  }

  @override
  void before() {
    dispatch(WaitAction.add("auto-login"));
  }

  @override
  void after() {
    if (state.error == ErrorType.none) {
      dispatch(AssignGroupsAction());
    } else {
      dispatch(WaitAction.remove("auto-login"));
    }
  }
}
