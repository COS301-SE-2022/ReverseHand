import 'package:redux_comp/actions/user/user_table/check_user_exists_action.dart';
import 'package:redux_comp/models/error_type_model.dart';
import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetCognitoUserAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    final userAttr = await Amplify.Auth.fetchUserAttributes();

    String email = "", id = "";
    for (AuthUserAttribute attr in userAttr) {
      switch (attr.userAttributeKey.key) {
        case "email":
          email = attr.value;
          break;
        case "sub":
          id = attr.value;
          break;
      }
    }
    switch (state.userDetails.userType) {
      case "Consumer":
        id = "c#$id";
        break;
      case "Tradesman":
        id = "t#$id";
        break;
      case "Admin":
        id = "admin#$id";
        break;
    }
    return state.copy(
        error: ErrorType.none,
        userDetails: state.userDetails.copy(
          id: id,
          email: email,
        ));
  }

  @override
  Future<void> after() async {
    if (state.error == ErrorType.none) {
      dispatch(CheckUserExistsAction());
    } else {
      dispatch(WaitAction.remove("auto-login"));
    }
  }
}
