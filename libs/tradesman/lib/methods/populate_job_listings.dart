import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:redux_comp/actions/view_adverts_action.dart';
import 'package:redux_comp/actions/view_bids_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:tradesman/pages/job_details.dart';

class JobListings extends StatelessWidget {
  final Store<AppState> store;

  const JobListings({
    Key? key,
    required this.store,
  }) : super(key: key);

  Column populateAdverts(List<AdvertModel> adverts, BuildContext context) {
    List<Widget> quickViewJobCardWidgets = [];
    for (AdvertModel advert in adverts) {
      quickViewJobCardWidgets.add(QuickViewJobCardWidget(
        advert: advert,
        store: store,
        // titleText: advert.title,
        // date: advert.dateCreated,
        // onTap: () {
        //   store.dispatch(ViewBidsAction(advert.id));
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (_) => TradesmanJobDetails(
        //         store: store,
        //         advert: advert,
        //       ),
        //     ),
        //   );
        // },
      ));
    }
    return Column(children: quickViewJobCardWidgets);
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: StoreConnector<AppState, List<AdvertModel>>(
              converter: (store) => store.state.user!.adverts,
              builder: (context, adverts) {
                store.dispatch(ViewAdvertsAction("c#001"));
                return populateAdverts(adverts, context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
