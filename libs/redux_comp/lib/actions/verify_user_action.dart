import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/foundation.dart';
import 'package:redux_comp/models/user_models/partial_user_model.dart';

import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

// import '../models/user_models/consumer_model.dart';

class VerifyUserAction extends ReduxAction<AppState> {
  final String confirmationCode;

  VerifyUserAction(this.confirmationCode);
  @override
  Future<AppState?> reduce() async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: state.partialUser!.email,
          confirmationCode: confirmationCode);

      if (res.nextStep.signUpStep == "DONE") {
        return state.replace(
          partialUser: PartialUser(
            state.partialUser!.email,
            state.partialUser!.password,
            res.nextStep.signUpStep,
          ),
        );
      } else {
        if (kDebugMode) {
          print(res.nextStep.signUpStep);
        }
        return state;
      }
// } on AuthException catch (e) {
    } catch (e) {
      return state;
    }
  }
}
