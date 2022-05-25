import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

import '../models/user_models/consumer_model.dart';

class VerifyUserAction extends ReduxAction<AppState> {
  final String username;
  final String confirmationCode;

  VerifyUserAction(this.username, this.confirmationCode);
  @override
  Future<AppState?> reduce() async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: username, confirmationCode: confirmationCode);
      // return state.replace(
      //      user: ConsumerModel(id, email, email));
// } on AuthException catch (e) {
    } catch (e) {
      return state;
    }
  }
}
