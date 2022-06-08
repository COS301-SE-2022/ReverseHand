import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/shortlist_bid_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:general/widgets/card.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:general/widgets/shortlist_accept_button.dart';

import '../consumer.dart';

//Populates the detailed information of a bid

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
              //*******************PADDING FOR THE TOP*******************//
              const Padding(padding: EdgeInsets.fromLTRB(10, 15, 10, 0)),

              //********************************************************//

              //**********************BACK BUTTON**********************//
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

              //********************************************************//

              //***********************CARD*****************************//
              CardWidget(
                titleText: "MR J SMITH",
                price1: bid.priceLower,
                price2: bid.priceUpper,
                details: "info@gmail.com",
                quote: false,
              ),

              //********************************************************//

              //***********PADDING BETWEEN CARD AND BUTTON*************//
              const Padding(padding: EdgeInsets.all(10)),
              //*******************************************************//

              //*******************BUTTON TO ACCEPT BID****************//
              ShortlistAcceptButtonWidget(
                onTap: () {
                  store.dispatch(ShortlistBidAction(advert.id, bid.id));
                },
              ),

              //********************************************************//
            ])),
      ),
    );
  }
}
