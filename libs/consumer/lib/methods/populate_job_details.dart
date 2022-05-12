import 'package:amplify/models/Advert.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

import '../pages/job_listings.dart';

class JobDetails extends StatelessWidget {
  final Advert advert;
  final Store<AppState> store;
  const JobDetails({Key? key, required this.advert,required this.store}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(82, 121, 111, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ConsumerListings(store: store)));
          },
        ),
        title: Text(advert.title ?? "Title: NULL" ),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Card(
                  color: const Color.fromRGBO(53, 79, 82, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 2,
                  child: Column(
                    children: [
                      const ListTile(
                        title: Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 25.0, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Text(
                          advert.description ?? "Description: NULL",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.9)),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 15,
                  thickness: 2,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.black.withOpacity(0.2),
                ),
                const Text(
                  "Active Bids",
                  style: TextStyle(fontSize: 25.0, color: Colors.black),
                ),
                Card(
                  color: const Color.fromRGBO(132, 169, 140, 1),
                  elevation: 2,
                  child: Column(
                    children: const [
                      ListTile(
                        title: Text(
                          'Bid One',
                          style: TextStyle(
                              fontSize: 25.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}