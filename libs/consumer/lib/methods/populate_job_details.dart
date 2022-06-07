import 'package:async_redux/async_redux.dart';
import 'package:consumer/consumer.dart';
import 'package:general/widgets/tab.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/job_card.dart';
import 'package:redux_comp/actions/view_bids_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:general/widgets/divider.dart';
import 'package:general/widgets/quick_view_bid.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';

class JobDetails extends StatelessWidget {
  final AdvertModel advert;
  final Store<AppState> store;
  const JobDetails({Key? key, required this.store, required this.advert})
      : super(key: key);

  Column populateBids(List<BidModel> bids, BuildContext context) {
    List<Widget> quickViewBidWidgets = [];
    //**********PADDING FROM TOP***********//
    quickViewBidWidgets
        .add(const Padding(padding: EdgeInsets.fromLTRB(10, 15, 10, 0)));

    //**********BACK BUTTON***********//
    quickViewBidWidgets.add(
      BackButton(
        color: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ConsumerListings(store: store)));
        },
      ),
    );

    //**********DETAILED JOB INFORMATION***********//
    quickViewBidWidgets.add(
      JobCardWidget(
        titleText: advert.title,
        descText: advert.description ?? "",
        date: advert.dateCreated,
        location: advert.location ?? "",
      ),
    );

    //**********DIVIDER***********//
    quickViewBidWidgets.add(
      const DividerWidget(),
    );

    //**********HEADING***********//
    quickViewBidWidgets.add(
      const Text(
        "BIDS",
        style: TextStyle(fontSize: 25.0, color: Colors.white),
      ),
    );

    //**********PADDING***********//
    quickViewBidWidgets.add(
      const Padding(padding: EdgeInsets.all(15)),
    );

    //**********TABS TO FILTER ACTIVE/SHORTLISTED BIDS***********//
    quickViewBidWidgets.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(padding: EdgeInsets.all(11)),
          TabWidget(text: "ACTIVE"),
          Padding(padding: EdgeInsets.all(5)),
          TabWidget(text: "SHORTLIST"),
          Padding(padding: EdgeInsets.all(11)),
        ],
      ),
    );

    //**********QUICK VIEW BID WIDGETS - TAKES YOU TO DETAILED BID VIEW ON CLICK***********//
    for (BidModel bid in bids) {
      quickViewBidWidgets.add(QuickViewBidWidget(
        name: bid.dateCreated, //this should be a name or a number
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ViewBid(store: store, bid: bid)));
        },
      ));
    }

    return Column(children: quickViewBidWidgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: StoreConnector<AppState, List<BidModel>>(
          converter: (store) => store.state.user!.bids,
          builder: (context, bids) {
            return populateBids(bids, context);
          },
        ),
      ),
    );
  }
}
