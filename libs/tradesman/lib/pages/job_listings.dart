import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:tradesman/methods/populate_job_listings.dart';
import 'package:redux_comp/redux_comp.dart';

class TradesmanJobListings extends StatelessWidget {
  final Store<AppState> store;
  const TradesmanJobListings({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: JobListings(store: store), 
        theme: CustomTheme.darkTheme
      ),
    );
  }
}
