import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './job_details.dart';
import 'package:redux/redux.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:flutter/rendering.dart';

class TradesmanJobListings extends StatelessWidget {
  final Store<AppState> store;
  const TradesmanJobListings({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return StoreProvider<AppState>(
      store: store,
      child: 
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Job Listings'),
            backgroundColor: const Color.fromRGBO(82, 121, 111, 1),
          ),
          body: ListView(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (_) => TradesmanJobDetails(store: store)));
                },
                child: Card(
                  color: const Color.fromARGB(255, 86, 159, 92),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 2,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                          child: Text(
                            '2 Days ago',
                            style: TextStyle(color: Colors.white.withOpacity(0.6)),
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Roof painting',
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        ),
                        subtitle: Text(
                          '22 May 2022 - 28 May 2022',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7), fontSize: 15.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Text(
                          'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                          style: TextStyle(color: Colors.white.withOpacity(0.9)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}
