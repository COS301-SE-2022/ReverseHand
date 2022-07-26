import '../app_state.dart';
import 'package:async_redux/async_redux.dart';

class ChangeAction extends ReduxAction<AppState> {
  @override
  AppState? reduce() {
    return state.copy(change: !state.change);
  }
}
