import 'package:redux_comp/models/bid_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class SetActiveBidAction extends ReduxAction<AppState> {
  final BidModel bid;

  SetActiveBidAction(this.bid);

  @override
  AppState? reduce() {
    // final BidModel bid = state.user!.bids.firstWhere(
    //     (element) => element.id == bidId,
    //     orElse: () => state.user!.shortlistBids
    //         .firstWhere((element) => element.id == bidId));

    return store.state.copy(activeBid: bid);
  }

  @override
  void after() => dispatch(NavigateAction.pushNamed(
      "/consumer/advert_details/bid_details")); // move to page after action completes
}
