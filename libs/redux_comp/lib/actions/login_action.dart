import 'dart:async';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:redux_comp/app_state.dart';

import '../models/user_models/user_model.dart';

class LoginAction extends ReduxAction<AppState> {
  final String email;
  final String password;

  LoginAction(this.email, this.password);

  @override
  Future<AppState?> reduce() async {
    try {
      await Amplify.Auth.signOut();
      SignInResult res = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );

      List<AuthUserAttribute> userAttr = await Amplify.Auth.fetchUserAttributes();

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
          default:
            break;
        }
        
      }
      return state.replace(
        user: UserModel(
          id, 
          username, 
          userType,
      ));
      // exception will be handled later
      // } on AuthException catch (e) {
    } catch (e) {
      // print(e.underlyingException);
      return state;
    }
    /*on ApiException catch (e) {
      // print(
      //     'Getting data failed $e'); // temp fix later, add error to store, through error class
      return state;
    }*/
  }
}
