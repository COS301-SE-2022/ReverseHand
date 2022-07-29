import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:redux_comp/actions/user/get_user_action.dart';
import 'package:redux_comp/models/error_type_model.dart';
import '../../app_state.dart';
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
      final data =
          jsonDecode((await Amplify.API.query(request: request).response).data);
      final user = data["viewUser"];

      if (user["id"] == "User Not Found") {
        return state.copy(
            userDetails: state.userDetails!.copy(
          registered: false,
        ));
      } else if (user["id"] == id) {
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
      // wait until error has finished before stopping loading
      await store.waitCondition((state) => state.error == ErrorType.none);
      dispatch(WaitAction.remove("flag"));
    }
  }
}
