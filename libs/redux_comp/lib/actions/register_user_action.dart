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
  final String userType;

  RegisterUserAction(this.username,this.name,this.cellNo,this.location, this.password, this.userType);

  @override
  Future<AppState?> reduce() async {
    try {
      Map<CognitoUserAttributeKey, String> userAttributes = {
        CognitoUserAttributeKey.email : username,
        CognitoUserAttributeKey.familyName: userType
      };

       SignUpResult res = await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: CognitoSignUpOptions(
          userAttributes: userAttributes
        )
      );

      if (res.nextStep.signUpStep == "CONFIRM_SIGN_UP_STEP") {
        // await Amplify.Auth.signIn(username: username, password: password);
        return state.replace(
          partialUser: PartialUser(
            username,
            password,
            res.nextStep.signUpStep        )
        );
      } else print(res.nextStep.signUpStep);

    } on AuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return state;
    } catch(e) {
      return state;
    }
  }
}
