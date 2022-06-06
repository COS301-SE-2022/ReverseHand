import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:redux_comp/actions/view_adverts_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import '../pages/create_new_job.dart';
import '../pages/job_details.dart';

class JobListings extends StatelessWidget {
  final Store<AppState> store;
  // final List<Advert?> adverts;

  const JobListings({
    Key? key,
    required this.store,
    /* required this.adverts */
  }) : super(key: key);

  Column populateAdverts(List<AdvertModel> adverts, BuildContext context) {
    List<Widget> quickViewJobCardWidgets = [];

    for (AdvertModel advert in adverts) {
      quickViewJobCardWidgets.add(QuickViewJobCardWidget(
        titleText: advert.title,
        date: advert.dateCreated,
        location: advert.location ?? "",
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => ConsumerDetails(store: store)));
        },
      ));
    }

    quickViewJobCardWidgets.add(
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              onPrimary: Colors.white,
              shadowColor: Colors.black,
              elevation: 9,
              textStyle: const TextStyle(fontSize: 30),
              minimumSize: const Size(60, 60),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CreateNewJob(store: store)));
            },
            child: const Text("+"), //Look into an icon for demo 3
          ),
        ),
      ),
    );
    quickViewJobCardWidgets.add(
      const Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      ),
    );

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
                sleep(const Duration(seconds: 5));
                return populateAdverts(adverts, context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
