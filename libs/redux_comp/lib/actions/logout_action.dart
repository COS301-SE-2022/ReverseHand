import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class LogoutAction extends ReduxAction<AppState> {
	@override
	Future<AppState?> reduce() async {
    try {
      Amplify.Auth.signOut();
      await store.deletePersistedState();
      return state;
    } catch (e) {
      return state;
    }
  }
}
