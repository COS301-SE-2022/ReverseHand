import 'package:flutter/foundation.dart';
import 'package:redux_comp/actions/user/add_user_to_group_action.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import '../../app_state.dart';

class VerifyUserAction extends ReduxAction<AppState> {
  final String confirmationCode;

  VerifyUserAction(this.confirmationCode);
  @override
  Future<AppState?> reduce() async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: state.partialUser!.email,
          confirmationCode: confirmationCode);

      // await Amplify.Auth.signOut();
      // await Amplify.Auth.signIn(
      //   username: state.partialUser!.email,
      //   password: state.partialUser!.password!,
      // );

      // AuthUser user = await Amplify.Auth.getCurrentUser();

      return state.copy(
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
    await dispatch(AddUserToGroupAction(state.partialUser!.email, state.partialUser!.group));
  }
}
