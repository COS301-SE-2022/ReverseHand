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
      final AuthUser user = await Amplify.Auth.getCurrentUser();
      final String group = state.partialUser!.group;

      if (res.nextStep.signUpStep == "DONE") {
        /* If the user is verified then the signUpStep is DONE, so we just update the partial user model and add the user to the correct group*/
        String graphQLDocOne = '''mutation  {
          addUserToGroup(email: "$username", group: "$group")
        }
        ''';
        final requestUserGroup = GraphQLRequest(
          document: graphQLDocOne,
        );

         try {
          await Amplify.API.mutate(request: requestUserGroup).response;
        } on ApiException catch (e) {
          debugPrint(e.message);
          return null;
        }

        final String name = state.partialUser!.email;
        final String id = (group == "customer") ? "c#${user.userId}" : "t#${user.userId}";
        final double lat = state.partialUser!.position!.latitude;
        final double long = state.partialUser!.position!.longitude;

        String graphQLDocTwo = '''mutation  {
          createUser(lat: "$lat", long: "$long", name: "$name", user_id: "$id") {
            id
          }
        }
        ''';

        final requestCreateUser = GraphQLRequest(
          document: graphQLDocTwo,
        );

        try {
          GraphQLResponse response = await Amplify.API.mutate(request: requestCreateUser).response;
          debugPrint(response.toString());

        } on ApiException catch (e) {
          debugPrint(e.message);
          return null;
        }


        return state.replace(
          partialUser: PartialUser(
            email: state.partialUser!.email,
            group: state.partialUser!.group,
            verified: res.nextStep.signUpStep,
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
