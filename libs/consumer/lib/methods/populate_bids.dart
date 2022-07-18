import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:general/widgets/quick_view_bid.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/bid_model.dart';

// function to create list of bids
List<Widget> populateBids(
    String userId, List<BidModel> bids, Store<AppState> store) {
  List<Widget> quickViewBidWidgets = [];

  for (BidModel bid in bids) {
    // checking when to append to front
    if (bid.userId == userId) {
      quickViewBidWidgets.insert(
        0,
        QuickViewBidWidget(
          bid: bid,
          store: store,
        ),
      );
    } else {
      quickViewBidWidgets.add(
        QuickViewBidWidget(
          bid: bid,
          store: store,
        ),
      );
    }
  }

  return quickViewBidWidgets;
}
