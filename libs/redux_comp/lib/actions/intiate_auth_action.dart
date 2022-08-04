import 'package:redux_comp/models/error_type_model.dart';

import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class IntiateAuthAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    final authSession = await Amplify.Auth.fetchAuthSession();
    if (authSession.isSignedIn == true) {
      return null;
    } else {
      return state.copy(error: ErrorType.userNotAuthorised);
    }
  }
}
