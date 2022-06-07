import 'package:async_redux/async_redux.dart';
import 'package:consumer/methods/populate_job_details.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/redux_comp.dart';

class ConsumerDetails extends StatelessWidget {
  final Store<AppState> store;
  final AdvertModel advert; //Not sure if this is how advert should be delcared?
  const ConsumerDetails({Key? key, required this.store, required this.advert})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: JobDetails(store: store, advert: advert),
        theme: CustomTheme.darkTheme,
      ),
    );
  }
}
