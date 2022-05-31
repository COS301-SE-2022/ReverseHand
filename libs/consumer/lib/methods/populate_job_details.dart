import 'package:amplify/models/Advert.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';
import 'package:general/widgets/divider.dart';
import 'package:general/widgets/textbox.dart';
import 'package:general/widgets/card.dart';

import '../pages/job_listings.dart';

class JobDetails extends StatelessWidget {
  final Advert advert;
  final Store<AppState> store;
  const JobDetails({Key? key, required this.store, required this.advert})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      // title: Text(advert.title ?? "Title: NULL"),

      body: Row(
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

                const Padding(
                  padding: EdgeInsets.all(20),
                ),
                const CardWidget(
                    titleText: "test",
                    price1: "test",
                    price2: "test",
                    details: "test",
                    quote: false),
                const DividerWidget(),
                const Text(
                  "BIDS",
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
                Container(
                    padding: const EdgeInsets.all(30),
                    child: const TextboxWidget(text: "Mr J Smith"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
