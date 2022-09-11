import 'package:redux_comp/models/admin/reported_advert_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class SetCurrentAdvertAction extends ReduxAction<AppState> {
  String reportId;
  SetCurrentAdvertAction(this.reportId);
  @override
  Future<AppState?> reduce() async {
    final ReportedAdvertModel advert = state.admin.activeAdverts!
        .firstWhere((element) => element.id == reportId);

    return state.copy(
      admin: state.admin.copy(activeAdvert: advert),
    );
  }

  @override
  void after() {
    dispatch(NavigateAction.pushNamed('/admin_consumer_advert_details'));
  }
}
