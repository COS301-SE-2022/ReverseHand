// all reducers should be in their own file (or at least logically grouped together) with name ending in reducer
import 'package:redux_comp/app_state.dart';

// actions in same file as the reducer that uses them
class ExampleAction {
  final String data;

  ExampleAction(this.data);
}

// note name of file and function, both end in reducer
AppState changeExampleReducer(AppState state, ExampleAction action) {
  // action and appstate must be passed in as they may contain data required
  return AppState(example: action.data); // changding the appstate
}
