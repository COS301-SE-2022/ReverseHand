import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:redux_comp/actions/user/user_table/get_user_action.dart';
import '../../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class CheckUserExistsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    String id = store.state.userDetails!.id;

    String graphQLDoc = '''query  {
        viewUser(user_id: "$id") {
          id        
        }
      }
      ''';

    final request = GraphQLRequest(
      document: graphQLDoc,
    );

    try {
      final resp = await Amplify.API.query(request: request).response;
      if (resp.errors.isNotEmpty) {
        for (var error in resp.errors) {
          switch (error.message) {
            case "No users found":
              return state.copy(
                  userDetails: state.userDetails!.copy(
                registered: false,
              ));
          }
        }
      }

      final user = jsonDecode((resp).data)["viewUser"];

      if (user["id"] == id) {
        store.dispatch(GetUserAction());
        return state.copy(
            userDetails: state.userDetails!.copy(
          registered: true,
        ));
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  void after() async {
    if (state.userDetails!.registered! == false) {
      dispatch(NavigateAction.pushNamed(
          '/${state.userDetails!.userType.toLowerCase()}/edit_profile_page'));
      dispatch(WaitAction.remove("flag"));
      dispatch(WaitAction.remove("auto-login"));
    }
  }
}
