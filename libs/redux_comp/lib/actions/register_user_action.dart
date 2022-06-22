import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import '../app_state.dart';
import '../models/user_models/partial_user_model.dart';

class RegisterUserAction extends ReduxAction<AppState> {
  final String username;
  final String name;
  final String cellNo;
  final String location;
  final String password;
  final bool userType;

  RegisterUserAction(this.username, this.name, this.cellNo, this.location,
      this.password, this.userType);

  @override
  Future<AppState?> reduce() async {
    try {
      /* You can specify which user attributes you want to store */
      /* For now we are using familyName to specify user type in future we will create a custome attribute */
      Map<CognitoUserAttributeKey, String> userAttributes = {
        CognitoUserAttributeKey.email: username,
        CognitoUserAttributeKey.name: name,
      };

      SignUpResult res = await Amplify.Auth.signUp(
          username: username,
          password: password,
          options: CognitoSignUpOptions(userAttributes: userAttributes));

      if (res.nextStep.signUpStep == "CONFIRM_SIGN_UP_STEP") {
        return state.replace(
            partialUser:
                PartialUser(username, userType ? "customer" : "tradesman", res.nextStep.signUpStep));
      } else {
        return null; /* do not modify state */
      }
    } on AuthException catch (e) {
      /* Cognito can throw a series of errors on signup */
      /* In future these will return error models to the state */
      debugPrint(e.message);
      return null;
    } catch (e) {
      return null;
    }
  }
}
