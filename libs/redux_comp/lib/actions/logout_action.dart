import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/foundation.dart';
import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class LogoutAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    try {
      /* Sign out the currently signed in user */
      await Amplify.Auth.signOut();
      /* Delete the store state */
      await store.deletePersistedState();
      return null;
    } on AuthException catch (e) {
      debugPrint(e.message);
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  void after() {
    dispatch(NavigateAction.pushNamed('/login'));
  }
}
