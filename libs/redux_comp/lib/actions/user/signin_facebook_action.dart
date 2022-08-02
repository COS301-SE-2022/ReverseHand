import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class SigninFacebookAction extends ReduxAction<AppState> {

  SigninFacebookAction();

  @override
  Future<AppState?> reduce() async {
    try {
      await Amplify.Auth.signOut();
      final result =
          await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);

      String id="", userType="", email ="";
      final info = await Amplify.Auth.fetchUserAttributes(); 
      final authSession = (await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true),
      )) as CognitoAuthSession;

      Map<String, dynamic> payload =
          Jwt.parseJwt(authSession.userPoolTokens!.accessToken);

      List groups = await payload["cognito:groups"];

      if (groups.contains("tradesman")) {
        userType = "Tradesman";
      } else if (groups.contains("customer")) {
        userType = "Consumer";
      }


      debugPrint(info.toString());
      return null;
    } on AmplifyException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
