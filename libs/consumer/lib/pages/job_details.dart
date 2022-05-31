import 'package:amplify/models/Advert.dart';
import 'package:async_redux/async_redux.dart';
import 'package:consumer/methods/populate_job_details.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/redux_comp.dart';

class ConsumerDetails extends StatelessWidget {
  final Store<AppState> store;
  final Advert? advert;
  const ConsumerDetails({Key? key, required this.store, required this.advert})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(home: JobDetails(advert: advert!, store: store)),
    );
  }
}

              // DividerWidget(),
              // Text("BIDS",
              //     style: TextStyle(
              //       fontSize: 30,
              //       color: Colors.white,
              //     )), add this and delete