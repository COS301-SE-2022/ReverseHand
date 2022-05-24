import 'package:amplify/models/Bid.dart';
import 'package:async_redux/async_redux.dart';
import 'package:consumer/methods/populate_bid_details.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

import 'package:general/widgets/card.dart';
import 'package:general/widgets/button.dart';
import 'package:redux_comp/models/user_models/consumer_model.dart';

class Bids extends StatelessWidget {
  final Store<AppState> store;
  const Bids({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(
            // body: StoreConnector<AppState, List<Bid>>(
            //   converter: (store) => (store.state.user as ConsumerModel).getBids(),
            //   builder: (context, bids) {
            //     return BidDetails(store: store, adverts: adverts);
            //   },
            // ), //this must be implemented AFTER job_details are altered, do not delete
            ),
      ),
    );
  }
}
