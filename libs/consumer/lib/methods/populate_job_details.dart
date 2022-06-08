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
import 'package:redux_comp/actions/toggle_view_bids_action.dart';

class JobDetails extends StatefulWidget {
  final AdvertModel advert;
  final Store<AppState> store;
  const JobDetails({Key? key, required this.store, required this.advert})
      : super(key: key);

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
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
                  builder: (_) => ConsumerListings(store: widget.store)));
        },
      ),
    );

    //**********DETAILED JOB INFORMATION***********//
    quickViewBidWidgets.add(
      JobCardWidget(
        titleText: widget.advert.title,
        descText: widget.advert.description ?? "",
        date: widget.advert.dateCreated,
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
        children: [
          TabWidget(
            text: "ACTIVE",
            onPressed: (activate) {
              widget.store.dispatch(ToggleViewBidsAction(false, activate));
            },
          ),
          const Padding(padding: EdgeInsets.all(5)),
          TabWidget(
            text: "SHORTLIST",
            onPressed: (activate) {
              widget.store.dispatch(ToggleViewBidsAction(true, activate));
            },
          ),
        ],
      ),
    );

    //**********QUICK VIEW BID WIDGETS - TAKES YOU TO DETAILED BID VIEW ON CLICK***********//
    for (BidModel bid in bids) {
      quickViewBidWidgets.add(QuickViewBidWidget(
        name: bid.id, // this should be a name or a number
        onTap: () {
          widget.store.dispatch(SetActiveBidAction(bid.id));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ViewBid(
                store: widget.store,
              ),
            ),
          );
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
          converter: (store) => store.state.user!.viewBids,
          builder: (context, bids) {
            widget.store.onChange.listen((event) {
              setState(() {});
            });
            return populateBids(bids, context);
          },
        ),
      ),
    );
  }
}
