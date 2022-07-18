import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:general/widgets/quick_view_bid.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/bid_model.dart';

// function to create list of bids
List<Widget> populateBids(
    String userId, List<BidModel> bids, Store<AppState> store) {
  List<Widget> quickViewBidWidgets = [
    const Text("This shouldn't be here"),
  ]; // temporary

  for (int i = 1; i < bids.length; i++) {
    // see when to replace temporarry variable
    if (bids[i].userId == userId) {
      quickViewBidWidgets[0] = QuickViewBidWidget(
        store: store,
        bid: bids[i],
      );
    } else {
      quickViewBidWidgets.add(
        QuickViewBidWidget(
          store: store,
          bid: bids[i],
        ),
      );
    }
  }

  return quickViewBidWidgets;
}
