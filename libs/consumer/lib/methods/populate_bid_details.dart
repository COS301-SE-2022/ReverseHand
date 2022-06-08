import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/accept_bid_action.dart';
import 'package:redux_comp/actions/shortlist_bid_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:general/widgets/card.dart';
import 'package:general/widgets/shortlist_accept_button.dart';
import '../consumer.dart';

class BidDetails extends StatefulWidget {
  final Store<AppState> store;

  const BidDetails({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  State<BidDetails> createState() => _BidDetailsState();
}

class _BidDetailsState extends State<BidDetails> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
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
                        store: widget.store,
                        advert: widget.store.state.user!.activeAd!,
                      ),
                    ),
                  );
                },
              ),
              CardWidget(
                titleText: "MR J SMITH",
                price1: widget.store.state.user!.activeBid!.priceLower,
                price2: widget.store.state.user!.activeBid!.priceUpper,
                details: "info@gmail.com",
                quote: false,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              StoreConnector<AppState, Future<void> Function()>(
                converter: (store) => () async {
                  store.state.user!.activeBid!.isShortlisted()
                      // if bid has been shortlisted
                      ? await store.dispatch(
                          AcceptBidAction(
                            store.state.user!.id,
                            store.state.user!.activeAd!.id,
                            store.state.user!.activeBid!
                                .id, // must be a shortlisted bid
                          ),
                        )
                      // if bid has not been shortlisted
                      : await store.dispatch(
                          ShortlistBidAction(
                            store.state.user!.activeAd!.id,
                            store.state.user!.activeBid!.id,
                          ),
                        );
                },
                builder: (context, reduce) {
                  return ShortlistAcceptButtonWidget(
                    store: widget.store,
                    onTap: () {
                      reduce().whenComplete(
                        () {
                          // if (widget.store.state.user!.activeBid!
                          //     .isShortlisted()) {
                          //   Navigator.pop(context);
                          // }
                        },
                      );
                    },
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
