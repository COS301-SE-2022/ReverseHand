import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import '../app_state.dart';
class RegisterUserAction extends ReduxAction<AppState> {
  final String username;
  final String password;

  RegisterUserAction(this.username, this.password);

  @override
  Future<AppState?> reduce() async {
    try {
      Map<CognitoUserAttributeKey, String> userAttributes = {
        CognitoUserAttributeKey.email: 'email@domain.com',
        // additional attributes as needed
      };
      SignUpResult res = await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: CognitoSignUpOptions(
          userAttributes: userAttributes
        )
      );
      return state.replace(
        username: username,
        signUpComplete: res.isSignUpComplete
        );
    } on AuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return state;
    }
    /*on ApiException catch (e) {
      // print(
      //     'Getting data failed $e'); // temp fix later, add error to store, through error class
      return state;
    }*/
  }
}
