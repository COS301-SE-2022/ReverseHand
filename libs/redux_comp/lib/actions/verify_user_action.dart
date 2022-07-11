import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/foundation.dart';
import 'package:redux_comp/actions/add_user_to_group_action.dart';
import 'package:redux_comp/actions/create_user_action.dart';
import 'package:redux_comp/actions/login_action.dart';
import 'package:redux_comp/actions/view_adverts_action.dart';
import 'package:redux_comp/actions/view_jobs_action.dart';
import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class VerifyUserAction extends ReduxAction<AppState> {
  final String confirmationCode;

  VerifyUserAction(this.confirmationCode);
  @override
  Future<AppState?> reduce() async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: state.partialUser!.email,
          confirmationCode: confirmationCode);

      await Amplify.Auth.signOut();
      await Amplify.Auth.signIn(
        username: state.partialUser!.email,
        password: state.partialUser!.password!,
      );

      AuthUser user = await Amplify.Auth.getCurrentUser();
    
      return state.replace(
        partialUser: state.partialUser!.replace(
          id: (state.partialUser!.group == "customer") ? "c#${user.userId}" : "t#${user.userId}",
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
  void after() async{
    await dispatch(AddUserToGroupAction());
    await dispatch(CreateUserAction());
  }
}
