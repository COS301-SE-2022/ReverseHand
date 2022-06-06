import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class ViewAdvertsAction extends ReduxAction<AppState> {
  final String cons_id; // consumer id whos adverts you wish to retrieve

  ViewAdvertsAction(this.cons_id);

  @override
  Future<AppState?> reduce() async {}
}
