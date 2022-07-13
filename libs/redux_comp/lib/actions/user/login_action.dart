import 'dart:async';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:redux_comp/actions/adverts/view_adverts_action.dart';
import 'package:redux_comp/actions/adverts/view_jobs_action.dart';
import 'package:redux_comp/actions/user/get_user_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:jwt_decode/jwt_decode.dart';

class LoginAction extends ReduxAction<AppState> {
  final String email;
  final String password;

  LoginAction(this.email, this.password);

  @override
  Future<AppState?> reduce() async {
    await store.waitCondition((state) => Amplify.isConfigured == true);

    try {
      await Amplify.Auth.signOut();

      /*SignInResult res = */ await Amplify.Auth.signIn(
        username: email,
        password: password,
      );

      AuthUser user = await Amplify.Auth.getCurrentUser();
      String id = user.userId, userType = "";

      final authSession = (await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true),
      )) as CognitoAuthSession;

      Map<String, dynamic> payload =
          Jwt.parseJwt(authSession.userPoolTokens!.accessToken);

      List groups = payload["cognito:groups"];

      if (groups.contains("tradesman")) {
        userType = "Tradesman";
      } else if (groups.contains("customer")) {
        userType = "Consumer";
      }

      return state.replace(
        user: state.user!.replace(
          id: (userType == "Consumer") ? "c#$id" : "t#$id",
          userType: userType,
        ),
      );
      /* Cognito will throw an AuthException object that is not fun to interact with */
      /* The most useful part of the AuthException is the AuthException message */
    } on AuthException catch (e) {
      switch (e.message) {
        case "User is not confirmed.":
          // print(e.message);
          return state.replace(
            error: ErrorType.userNotFound,
          );
        case "User does not exist.":
          debugPrint(e.message);
          return state.replace(
            error: ErrorType.userNotFound,
          );
        case "Incorrect username or password.":
          debugPrint(e.message);
          return state.replace(
            error: ErrorType.userInvalidPassword,
          );
        case "Password attempts exceeded":
          debugPrint(e.message);
          return state.replace(
            error: ErrorType.passwordAttemptsExceeded,
          );
        default:
          debugPrint(e.message);
          return null;
      }
    }
    /*on ApiException catch (e) {
      // print(
      //     'Getting data failed $e'); // temp fix later, add error to store, through error class
      return state;
    }*/
  }

  @override
  void after() async {
    await dispatch(GetUserAction());
    state.user!.userType == "Consumer"
        ? await dispatch(ViewAdvertsAction(state.user!.id))
        : await dispatch(ViewJobsAction());
    dispatch(
        NavigateAction.pushNamed("/${state.user!.userType.toLowerCase()}"));
  } // we know that state wont be null
}
