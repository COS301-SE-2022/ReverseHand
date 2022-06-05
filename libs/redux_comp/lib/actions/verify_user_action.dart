import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:redux_comp/models/user_models/partial_user_model.dart';

import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

import '../models/user_models/user_model.dart';

// import '../models/user_models/consumer_model.dart';

class VerifyUserAction extends ReduxAction<AppState> {
  final String username;
  final String password;
  final String confirmationCode;

  VerifyUserAction(this.username, this.password, this.confirmationCode);
  @override
  Future<AppState?> reduce() async {
    try {
      SignUpResult res =  await Amplify.Auth.confirmSignUp(
          username: username, confirmationCode: confirmationCode);

      if (res.nextStep.signUpStep == "DONE") {
        return state.replace(
          partialUser: PartialUser(username, password,res.nextStep.signUpStep)
        );
      } else print(res.nextStep.signUpStep);
       return state;// .replace(
      //      user: ConsumerModel(id, email, email));
// } on AuthException catch (e) {
    } catch (e) {
      return state;
    }
  }
}
