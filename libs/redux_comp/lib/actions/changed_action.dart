import '../app_state.dart';
import 'package:async_redux/async_redux.dart';

// used to just represent changed
class ChangedAction extends ReduxAction<AppState> {
  @override
  AppState? reduce() {
    return state.copy(change: !state.change);
  }
}
