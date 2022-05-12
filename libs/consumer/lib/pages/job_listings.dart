import 'package:amplify/models/Advert.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import '../methods/populate_job_listings.dart';
import 'package:redux_comp/redux_comp.dart';

class ConsumerListings extends StatelessWidget {
  final Store<AppState> store;
  const ConsumerListings({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('My Job Listings'),
            backgroundColor: const Color.fromRGBO(82, 121, 111, 1),
          ),
          body: 
          StoreConnector<AppState, List<Advert?>> (
            converter: (store) => store.state.adverts,
            builder: (context, adverts) {
              return JobListings(store: store, adverts: adverts);
            },
          )
        ),
      ),
    );
  }
}
