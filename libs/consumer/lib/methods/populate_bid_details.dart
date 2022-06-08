import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/shortlist_bid_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:general/widgets/card.dart';
import 'package:general/widgets/shortlist_accept_button.dart';

import '../consumer.dart';

class BidDetails extends StatelessWidget {
  final Store<AppState> store;

  const BidDetails({
    Key? key,
    required this.store,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            children: <Widget>[
              const Padding(padding: EdgeInsets.fromLTRB(10, 15, 10, 0)),
              BackButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ConsumerDetails(
                        store: store,
                        advert: store.state.user!.activeAd!,
                      ),
                    ),
                  );
                },
              ),
              CardWidget(
                titleText: "MR J SMITH",
                price1: store.state.user!.activeBid!.priceLower,
                price2: store.state.user!.activeBid!.priceUpper,
                details: "info@gmail.com",
                quote: false,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ShortlistAcceptButtonWidget(
                isShorListedBid: store.state.user!.activeBid!.isShortlisted(),
                onTap: () {
                  store.dispatch(
                    ShortlistBidAction(
                      store.state.user!.activeAd!.id,
                      store.state.user!.activeBid!.id,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
