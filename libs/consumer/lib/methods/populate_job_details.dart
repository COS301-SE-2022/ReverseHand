import 'package:async_redux/async_redux.dart';
import 'package:consumer/consumer.dart';
import 'package:consumer/methods/populate_bid_details.dart';
import 'package:general/widgets/tab.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/job_card.dart';
import 'package:redux_comp/app_state.dart';
import 'package:general/widgets/divider.dart';
import 'package:general/widgets/quick_view_bid.dart';

class JobDetails extends StatelessWidget {
  // final Advert advert;
  final Store<AppState> store;
  const JobDetails({Key? key, /*required this.advert, */ required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.fromLTRB(10, 15, 10, 0)),
                  BackButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ConsumerListings(store: store)));
                    },
                  ),
                  const JobCardWidget(
                    titleText: "PAINTING",
                    descText: "Painting of one outer wall.",
                    date: "25 May 2022",
                    location: "Menlopark, Pretoria",
                  ),
                  const DividerWidget(),
                  const Text(
                    "BIDS",
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                  const Padding(padding: EdgeInsets.all(15)),
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
                  QuickViewBidWidget(
                    name: 'name',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ViewBid(store: store)));
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
