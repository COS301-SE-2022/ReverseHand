import 'package:flutter/foundation.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:redux_comp/actions/user/amplify_auth/login_action.dart';
import 'package:redux_comp/models/error_type_model.dart';
import '../../../app_state.dart';

class VerifyUserAction extends ReduxAction<AppState> {
  final String confirmationCode;

  VerifyUserAction(this.confirmationCode);
  @override
  Future<AppState?> reduce() async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: state.partialUser!.email,
          confirmationCode: confirmationCode);

      return state.copy(
        error: ErrorType.none,
        partialUser: state.partialUser!.copy(
          // id: (state.partialUser!.group == "customer") ? "c#${user.userId}" : "t#${user.userId}",
          verified: res.nextStep.signUpStep,
        ),
      );
    } on AuthException catch (e) {
      debugPrint(e.message); /* Error handling will be done later */
      return null; /* On Error do not modify state */
    } catch (e) {
      return null;
    }
  }

  @override
  void after() async {
    await dispatch(LoginAction(state.partialUser!.email, state.partialUser!.password!));
  }
}
