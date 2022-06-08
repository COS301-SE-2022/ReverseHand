import 'package:async_redux/async_redux.dart';
import 'package:consumer/consumer.dart';
import 'package:general/widgets/tab.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/job_card.dart';
import 'package:redux_comp/app_state.dart';
import 'package:general/widgets/divider.dart';
import 'package:general/widgets/quick_view_bid.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:redux_comp/actions/set_active_bid_action.dart';

class JobDetails extends StatelessWidget {
  final AdvertModel advert;
  final Store<AppState> store;
  const JobDetails({Key? key, required this.store, required this.advert})
      : super(key: key);

  Column populateBids(List<List<BidModel>> bids, BuildContext context) {
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
        // location: advert.location ?? "",
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
          TabWidget(text: "ACTIVE"),
          Padding(padding: EdgeInsets.all(5)),
          TabWidget(text: "SHORTLIST"),
        ],
      ),
    );

    //**********QUICK VIEW BID WIDGETS - TAKES YOU TO DETAILED BID VIEW ON CLICK***********//
    for (List<BidModel> bid in bids) {
      for (BidModel b in bid) {
        quickViewBidWidgets.add(QuickViewBidWidget(
          name: b.id, // this should be a name or a number
          onTap: () {
            store.dispatch(SetActiveBidAction(b.id));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ViewBid(
                  store: store,
                ),
              ),
            );
          },
        ));
      }
    }

    return Column(children: quickViewBidWidgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: StoreConnector<AppState, List<List<BidModel>>>(
          converter: (store) =>
              [store.state.user!.bids, store.state.user!.shortlistBids],
          builder: (context, bids) {
            return populateBids(bids, context);
          },
        ),
      ),
    );
  }
}
