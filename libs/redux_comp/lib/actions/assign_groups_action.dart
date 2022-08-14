import 'package:jwt_decode/jwt_decode.dart';
import 'package:redux_comp/actions/get_cognito_user_action.dart';
import 'package:redux_comp/actions/user/cognito/refresh_user_token_action.dart';
import 'package:redux_comp/models/error_type_model.dart';

import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class AssignGroupsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    Map<String, dynamic> payload = Jwt.parseJwt(state.authModel!.accessToken);
    String? externalName = payload["username"];

    List<String>? groups = List<String>.from(
      (payload["cognito:groups"] == null) ? [] : payload["cognito:groups"]!,
    );
    String userType = state.userDetails!.userType;
    if (groups.isNotEmpty) {
      if (groups.contains("customer")) {
        userType = "Consumer";
      } else if (groups.contains("tradesman")) {
        userType = "Tradesman";
      } else {
        return state.copy(
            error: ErrorType.userNotInGroup,
            userDetails:
                state.userDetails!.copy(externalUsername: externalName));
      }
    } else {
      return state.copy(
          error: ErrorType.userNotInGroup,
          userDetails: state.userDetails!.copy(externalUsername: externalName));
    }

    return state.copy(
        error: ErrorType.none,
        userDetails: state.userDetails!.copy(userType: userType));
  }

  @override
  void before() async {
    await dispatch(RefreshUserTokenAction(state.authModel!.refreshToken));
  }

  @override
  void after() async {
    if (state.error == ErrorType.none) {
      dispatch(GetCognitoUserAction());
    } else if (state.error == ErrorType.userNotInGroup) {
      dispatch(WaitAction.remove("flag"));
      dispatch(NavigateAction.pushNamed('/usertype_selection'));
    }
  }
}
