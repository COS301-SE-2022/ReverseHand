import 'package:redux_comp/models/advert_model.dart';
import '../app_state.dart';
import 'package:async_redux/async_redux.dart';

class SetActiveAdAction extends ReduxAction<AppState> {
  final String adId;

  SetActiveAdAction(this.adId);

  @override
  AppState? reduce() {
    final AdvertModel ad =
        state.user!.adverts.firstWhere((element) => element.id == adId);

    return store.state.replace(user: store.state.user!.replace(activeAd: ad));
  }
}
