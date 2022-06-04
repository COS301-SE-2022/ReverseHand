import 'package:async_redux/async_redux.dart';
import 'package:consumer/methods/populate_bid_details.dart';
import 'package:consumer/methods/populate_job_details.dart';
import 'package:consumer/methods/populate_shortlisted_bid.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:redux_comp/redux_comp.dart';

class ViewShortlistedBid extends StatelessWidget {
  final Store<AppState> store;
  const ViewShortlistedBid({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: ShortListBidDetails(store: store),
        theme: CustomTheme.darkTheme,
      ),
    );
  }
}
