import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:tradesman/methods/populate_job_details.dart';

class TradesmanJobDetails extends StatelessWidget {
  final Store<AppState> store;
 final AdvertModel advert; //Not sure if this is how advert should be delcared?
  const TradesmanJobDetails({Key? key, required this.store, required this.advert})
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
