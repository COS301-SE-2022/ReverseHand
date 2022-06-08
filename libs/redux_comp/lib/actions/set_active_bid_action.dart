import 'package:redux_comp/models/bid_model.dart';
import '../app_state.dart';
import 'package:async_redux/async_redux.dart';

class SetActiveBidAction extends ReduxAction<AppState> {
  final String bidId;

  SetActiveBidAction(this.bidId);

  @override
  AppState? reduce() {
    final BidModel bid = state.user!.bids.firstWhere(
        (element) => element.id == bidId,
        orElse: () => state.user!.shortlistBids
            .firstWhere((element) => element.id == bidId));

    return store.state.replace(user: store.state.user!.replace(activeBid: bid));
  }
}