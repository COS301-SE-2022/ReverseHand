import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import '../../app_state.dart';

class RegisterUserAction extends ReduxAction<AppState> {
  final String username;
  final String password;
  final bool userType; // true for customer

  RegisterUserAction(this.username, this.password, this.userType);

  @override
  Future<AppState?> reduce() async {
    try {
      SignUpResult res =
          await Amplify.Auth.signUp(username: username, password: password);

      if (res.nextStep.signUpStep == "CONFIRM_SIGN_UP_STEP") {
        if (userType) {
          return state.copy(
              partialUser: state.partialUser!.copy(
                  email: username,
                  password: password,
                  group: "customer",
                  verified: res.nextStep.signUpStep));
        } else {
          return state.copy(
              partialUser: state.partialUser!.copy(
                  email: username,
                  password: password,
                  group: "tradesman",
                  verified: res.nextStep.signUpStep));
        }
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

  // @override
  // void before() async {
  //  await dispatch(GetPlaceAction());
  // }
}
