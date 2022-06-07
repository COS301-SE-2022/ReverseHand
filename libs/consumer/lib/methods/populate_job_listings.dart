import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:redux_comp/actions/view_bids_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import '../pages/create_new_job.dart';
import '../pages/job_details.dart';

class JobListings extends StatelessWidget {
  final Store<AppState> store;

  const JobListings({
    Key? key,
    required this.store,
  }) : super(key: key);

  Column populateAdverts(List<AdvertModel> adverts, BuildContext context) {
    List<Widget> quickViewJobCardWidgets = [];
    double height = (MediaQuery.of(context).size.height) / 3;

    quickViewJobCardWidgets
        .add(const Padding(padding: EdgeInsets.only(top: 20)));

    for (AdvertModel advert in adverts) {
      quickViewJobCardWidgets.add(QuickViewJobCardWidget(
        titleText: advert.title,
        date: advert.dateCreated,
        onTap: () {
          store.dispatch(ViewBidsAction(advert.id));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ConsumerDetails(
                store: store,
                advert: advert,
              ),
            ),
          );
        },
      ));
    }

    quickViewJobCardWidgets.add(
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.all(height / 3),
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
                return populateAdverts(adverts, context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
