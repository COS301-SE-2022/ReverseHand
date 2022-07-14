import 'package:redux_comp/models/bid_model.dart';
import '../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class ToggleViewBidsAction extends ReduxAction<AppState> {
  final bool
      toggleShort; // whether we are toggling shortlisted bids or normal bids
  final bool activate; // whether we are enabling or disabling

  ToggleViewBidsAction(this.toggleShort, this.activate);

  @override
  AppState? reduce() {
    final List<BidModel> bids;
    if (toggleShort) {
      bids = state.user!.shortlistBids;
    } else {
      bids = state.user!.bids;
    }

    List<BidModel> viewBids = state.user!.viewBids;

    if (activate) {
      viewBids.addAll(bids);
    } else {
      for (BidModel b in bids) {
        viewBids.removeWhere((element) => element.id == b.id);
      }
    }

    return state.replace(
      user: state.user!.replace(
        viewBids: viewBids,
      ),
      change: !state.change, // to show that state has changed
    );
  }
}