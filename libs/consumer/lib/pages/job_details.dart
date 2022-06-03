import 'package:async_redux/async_redux.dart';
import 'package:consumer/methods/populate_job_details.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/redux_comp.dart';

class ConsumerDetails extends StatelessWidget {
  final Store<AppState> store;
  const ConsumerDetails({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(home: JobDetails(store: store)),
    );
  }
}
