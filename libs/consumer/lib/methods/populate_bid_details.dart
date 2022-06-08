import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/shortlist_bid_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:general/widgets/card.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:general/widgets/shortlist_accept_button.dart';

import '../consumer.dart';

class BidDetails extends StatelessWidget {
  final Store<AppState> store;
  final AdvertModel advert;
  final BidModel bid;
  const BidDetails(
      {Key? key, required this.store, required this.bid, required this.advert})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(children: <Widget>[
              const Padding(padding: EdgeInsets.fromLTRB(10, 15, 10, 0)),
              BackButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              ConsumerDetails(store: store, advert: advert)));
                },
              ),
              CardWidget(
                titleText: "MR J SMITH",
                price1: bid.priceLower,
                price2: bid.priceUpper,
                details: "info@gmail.com",
                quote: false,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ShortlistAcceptButtonWidget(
                onTap: () {
                  store.dispatch(ShortlistBidAction(advert.id, bid.id));
                },
              ),
            ])),
      ),
    );
  }
}
