import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/divider.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/job_card.dart';
import 'package:general/widgets/dialog_helper.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:tradesman/pages/job_listings.dart';
import 'package:tradesman/widgets/place_bid_popup.dart';

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
                  builder: (_) => TradesmanJobListings(store: store)));
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
        "Information",
        style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );

    //**********PADDING***********//
    quickViewBidWidgets.add(
      const Padding(padding: EdgeInsets.all(15)),
    );

    //**********Consumer Information***********//
    quickViewBidWidgets.add(
      Column(
        children: const <Widget>[
          Text(
            "Client name: Luke Skywalker",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Client cellphone: +27 89 076 2347",
             style: TextStyle(fontSize: 20),
          ),
           Text(
            "Client email: consumer@gmail.com",
             style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );

    //**********PADDING***********//
    quickViewBidWidgets.add(
      const Padding(padding: EdgeInsets.all(15)),
    );

    //**********Place Bid***********//
    quickViewBidWidgets.add(
      ButtonWidget(
        function: () {
            DialogHelper.display(
              context,
              const PlaceBidPopupWidget(),
            ); //trigger Place Bid popup
        },
        text: 'Place Bid',),
    );


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