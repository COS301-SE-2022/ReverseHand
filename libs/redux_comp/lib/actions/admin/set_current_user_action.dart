import 'package:redux_comp/models/admin/reported_user_model.dart';

import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class SetCurrentUserAction extends ReduxAction<AppState> {
  final String userId;

  SetCurrentUserAction(this.userId);

  @override
  Future<AppState?> reduce() async {
    final ReportedUserModel user = state.admin.reportedCustomers
        .firstWhere((element) => element.id == userId);

    return state.copy(
      admin: state.admin.copy(activeUser: user),
    );
  }

  @override
  void after() {
    if (state.admin.activeUser != null) {
      dispatch(NavigateAction.pushNamed('/admin_consumer_profile'));
    }
  }
}
