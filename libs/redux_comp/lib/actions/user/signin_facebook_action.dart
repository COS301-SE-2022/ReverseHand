// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/user/amplify_auth/check_signed_in_action.dart';
// import 'package:jwt_decode/jwt_decode.dart';

import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class SigninFacebookAction extends ReduxAction<AppState> {
  SigninFacebookAction();

  @override
  Future<AppState?> reduce() async {
    try {
      // Amplify.Auth.signOut();
      // final result =
      await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);

      // String id="", userType="", email ="";
      final authSession =  await Amplify.Auth.fetchAuthSession();
      if (authSession.isSignedIn) {
        dispatch(CheckSignedInAction());
      }

      return null;
    } on AmplifyException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}