import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:general/widgets/quick_view_bid.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/bid_model.dart';

// function to create list of bids
List<Widget> populateBids(
  List<BidModel> bids,
  Store<AppState> store, {
  bool archived = false,
}) {
  List<Widget> quickViewBidWidgets = [];

  //**********QUICK VIEW BID WIDGETS - TAKES YOU TO DETAILED BID VIEW ON CLICK***********//
  // for (BidModel bid in bids) {
  for (BidModel bid in bids) {
    quickViewBidWidgets.add(QuickViewBidWidget(
      bid: bid,
      store: store,
      archived: archived,
    ));
  }

  return quickViewBidWidgets;
}
