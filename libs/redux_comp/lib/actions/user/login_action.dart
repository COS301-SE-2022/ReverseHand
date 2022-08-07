import 'dart:async';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:redux_comp/actions/chat/subscribe_messages_action.dart';
import 'package:redux_comp/actions/intiate_auth_action.dart';
import 'package:redux_comp/actions/user/check_user_exists_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:jwt_decode/jwt_decode.dart';

class LoginAction extends ReduxAction<AppState> {
  final String email;
  final String password;

  LoginAction(this.email, this.password);

  @override
  Future<AppState?> reduce() async {
    await store.waitCondition((_) => Amplify.isConfigured == true);

    try {
      // await Amplify.Auth.signOut();

      SignInResult res =  await Amplify.Auth.signIn(
        username: email,
        password: password,
      );

      return state.copy(
        error: ErrorType.none
      );
      /* Cognito will throw an AuthException object that is not fun to interact with */
      /* The most useful part of the AuthException is the AuthException message */
    } on AuthException catch (e) {
      switch (e.message) {
        case "User is not confirmed.":
          // print(e.message);
          return state.copy(
            error: ErrorType.userNotFound,
          );
        case "Username is required to signIn":
          // print(e.message);
          return state.copy(
            error: ErrorType.noInput,
          );
        case "User does not exist.":
          debugPrint(e.message);
          return state.copy(
            error: ErrorType.userNotFound,
          );
        case "Incorrect username or password.":
          debugPrint(e.message);
          return state.copy(
            error: ErrorType.userInvalidPassword,
          );
        case "Password attempts exceeded":
          debugPrint(e.message);
          return state.copy(
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
  void before() => dispatch(WaitAction.add("flag"));

  @override
  void after() async {
    if (state.error == ErrorType.none) {
      await dispatch(IntiateAuthAction());

    } else {
      dispatch(WaitAction.remove("flag"));
    }
  }
}
