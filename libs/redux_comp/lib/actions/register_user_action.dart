// import 'package:amplify/amplify.dart';
// import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
// import 'package:redux_comp/models/user_models/consumer_model.dart';
import '../app_state.dart';
import '../models/user_models/consumer_model.dart';

class RegisterUserAction extends ReduxAction<AppState> {
  final String username;
  final String name;
  final String cellNo;
  final String location;
  final String password;

  RegisterUserAction(this.username,this.name,this.cellNo,this.location, this.password);

  @override
  Future<AppState?> reduce() async {
    try {
      Map<CognitoUserAttributeKey, String> userAttributes = {
        CognitoUserAttributeKey.email : username,
        CognitoUserAttributeKey.phoneNumber: cellNo
      };

       SignUpResult res = await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: CognitoSignUpOptions(
          userAttributes: userAttributes
        )
      );

      if (res.isSignUpComplete) {
        Amplify.Auth.signIn(username: username, password: password);
      }
      String uID = (await Amplify.Auth.getCurrentUser()).userId;

      return state.replace(
        ConsumerModel(
          uID,
          name,
          username,
          res.nextStep.signUpStep        )
      );
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
