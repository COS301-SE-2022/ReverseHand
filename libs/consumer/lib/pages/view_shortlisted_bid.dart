// import 'package:amplify/models/Bid.dart';
import 'package:async_redux/async_redux.dart';
// import 'package:consumer/methods/populate_bid_details.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

class ShortListBids extends StatelessWidget {
  final Store<AppState> store;
  const ShortListBids({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: const MaterialApp(
        home: Scaffold(),
      ),
    );
  }
}
