import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:tradesman/widgets/quick_view_bid_widget.dart';

// function to create list of bids
List<Widget> populateBids(
    String userId, List<BidModel> bids, Store<AppState> store) {
  List<Widget> quickViewBidWidgets = [];

  for (BidModel bid in bids) {
    // checking when to append to front
    quickViewBidWidgets.insert(
      0,
      TQuickViewBidWidget(
        bid: bid,
        store: store,
      ),
    );
  }

  return quickViewBidWidgets;
}
