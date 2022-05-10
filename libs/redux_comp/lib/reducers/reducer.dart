import 'package:redux_comp/actions/actions/example_action.dart';
import 'package:redux_comp/reducers/reducers/example_reducer.dart';

import '../app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is ExampleAction) return changeExampleReducer(state, action);
  return state; // if nothing new return state
}
