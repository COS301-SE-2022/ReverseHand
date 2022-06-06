import 'package:async_redux/async_redux.dart';
import 'package:consumer/consumer.dart';
import 'package:consumer/methods/populate_bid_details.dart';
import 'package:general/widgets/tab.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/job_card.dart';
import 'package:redux_comp/app_state.dart';
import 'package:general/widgets/divider.dart';

// import '../pages/job_listings.dart';
// this import will be used when backend is linked again

class JobDetails extends StatelessWidget {
  // final Advert advert;
  final Store<AppState> store;
  const JobDetails({Key? key, /*required this.advert, */ required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      // title: Text(advert.title ?? "Title: NULL"),

      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  // Card(
                  //   color: const Color.fromRGBO(53, 79, 82, 1),
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(15.0),
                  //   ),
                  //   elevation: 2,
                  //   child: Column(
                  //     children: [
                  //       const ListTile(
                  //         title: Text(
                  //           "Description",
                  //           style: TextStyle(fontSize: 25.0, color: Colors.white),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  //         child: Text(
                  //            advert.description ?? "Description: NULL",
                  //           style:
                  //               TextStyle(color: Colors.white.withOpacity(0.9)),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  //KEEP COMMENTS UNTIL BACKEND IS LINKED
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(255, 153, 0, 1),
                                width: 2.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: const Text(
                            "Mr J Smith",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BidDetails(store: store)));
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
