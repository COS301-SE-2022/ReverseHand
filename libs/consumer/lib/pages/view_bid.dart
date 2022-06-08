import 'package:async_redux/async_redux.dart';
import 'package:consumer/methods/populate_bid_details.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:redux_comp/redux_comp.dart';

class ViewBid extends StatelessWidget {
  final Store<AppState> store;
  final BidModel bid;
  final AdvertModel advert;
  const ViewBid(
      {Key? key, required this.store, required this.bid, required this.advert})
      : super(key: key);

  //*****Calls method to view detailed information of a bid*****//
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: BidDetails(
          store: store,
          bid: bid,
          advert: advert,
        ),
        theme: CustomTheme.darkTheme,
      ),
    );
  }
}
