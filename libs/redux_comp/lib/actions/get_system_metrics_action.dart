import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class GetSystemMetricsAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    final reqBody = {};
  }
}