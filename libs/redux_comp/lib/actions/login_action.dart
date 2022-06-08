import 'dart:async';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/models/user_models/partial_user_model.dart';
import '../models/user_models/user_model.dart';

class LoginAction extends ReduxAction<AppState> {
  final String email;
  final String password;

  LoginAction(this.email, this.password);

  @override
  Future<AppState?> reduce() async {
    await store.waitCondition((state) => Amplify.isConfigured == true);

    try {
      await Amplify.Auth.signOut();
      if (store.state.partialUser != null) {
        await store
            .waitCondition((state) => state.partialUser!.verified == "DONE");
      }
      /*SignInResult res = */ await Amplify.Auth.signIn(
        username: email,
        password: password,
      );

      List<AuthUserAttribute> userAttr =
          await Amplify.Auth.fetchUserAttributes();

      /* Since fetching user attributes is async, it returns the attributes unordered */
      /* This simple for loop & case statement will iterate through the list and check the attribute key */
      /* to assign it to the correct vairable */
      String id = "", username = "", userType = "";
      for (var attr in userAttr) {
        switch (attr.userAttributeKey.key) {
          case "sub":
            id = attr.value;
            break;
          case "email":
            username = attr.value;
            break;
          case "family_name":
            userType = attr.value;
            break;
        }
      }
      return state.replace(
        user: UserModel(
          id: userType == "Consumer" ? "c#$id" : "t#$id",
          email: username,
          userType: userType,
          bids: const [],
          shortlistBids: const [],
          viewBids: const [],
          adverts: const [],
        ),
        loading: false,
      );
      // exception will be handled later
    } on AuthException catch (e) {
      switch (e.message) {
        case "User is not confirmed.":
          // print(e.message);
          return state.replace(
            partialUser: PartialUser(email, password, "CONFIRM_SIGN_UP_STEP"),
            error: ErrorType.userNotFound,
          );
        case "User does not exist.":
          // print(e.message);
          return state.replace(
            error: ErrorType.userNotFound,
          );
        case "Incorrect username or password.":
          // print(e.message);
          return state.replace(
            error: ErrorType.userInvalidPassword,
          );
        case "Password attempts exceeded":
          // print(e.message);
          return state.replace(
            error: ErrorType.passwordAttemptsExceeded,
          );
        default:
          // print(e);
          break;
      }
      if (kDebugMode) {
        print(e);
      }
      return state;
    }
    /*on ApiException catch (e) {
      // print(
      //     'Getting data failed $e'); // temp fix later, add error to store, through error class
      return state;
    }*/
  }

  @override
  void after() => dispatch(NavigateAction.pushNamed(
      "/${state.user!.userType.toLowerCase()}")); // we know that state wont be null
}
