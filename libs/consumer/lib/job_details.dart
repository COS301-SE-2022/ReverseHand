import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/redux_comp.dart';
import './job_listings.dart';

class ConsumerDetails extends StatelessWidget {
  ///const Login({Key? key}) : super(key: key);
  final Store<AppState> store;
  const ConsumerDetails({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(
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
            title: const Text('ROOF PAINTING'),
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
                              'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
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
        ),
      ),
    );
  }
}
