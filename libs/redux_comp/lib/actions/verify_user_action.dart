import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/foundation.dart';
import 'package:redux_comp/models/user_models/partial_user_model.dart';
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

      final String username = state.partialUser!.email;
      final String group = state.partialUser!.group;

      if (res.nextStep.signUpStep == "DONE") {
        /* If the user is verified then the signUpStep is DONE, so we just update the partial user model */
        String graphQLDocument = '''mutation  {
          addUserToGroup(email: "$username", group: "$group")
        }
        ''';

        final request = GraphQLRequest(
          document: graphQLDocument,
        );

        try {
          await Amplify.API.mutate(request: request).response;
        } catch (e) {
          return null;
        }

        return state.replace(
          partialUser: PartialUser(
            state.partialUser!.email,
            state.partialUser!.group,
            res.nextStep.signUpStep,
          ),
        );
      } else {
        debugPrint(res.nextStep.signUpStep);
        return null; /* if the user fails the CONFIRM_SIGNUP_STEP do not modify the state. */
      }
    } on AuthException catch (e) {
      debugPrint(e.message); /* Error handling will be done later */
      return null; /* On Error do not modify state */
    } catch (e) {
      return null;
    }
  }

  @override
  void after() => dispatch(NavigateAction.pushNamed("/login"));
}
