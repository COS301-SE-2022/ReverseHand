import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:general/widgets/quick_view_bid.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/bid_model.dart';

// function to create list of bids
List<Widget> populateBids(List<BidModel> bids, Store<AppState> store) {
  List<Widget> quickViewBidWidgets = [];

  //**********QUICK VIEW BID WIDGETS - TAKES YOU TO DETAILED BID VIEW ON CLICK***********//
  // for (BidModel bid in bids) {
  for (int i = 0; i < bids.length; i++) {
    quickViewBidWidgets.add(QuickViewBidWidget(
      name: "Bid $i",
      bid: bids[i],
      store: store,
    ));
  }

  return quickViewBidWidgets;
}
