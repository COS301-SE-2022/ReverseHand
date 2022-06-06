import 'package:async_redux/async_redux.dart';
import 'package:consumer/consumer.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

import 'package:general/widgets/card.dart';

class BidDetails extends StatelessWidget {
  final Store<AppState> store;
  const BidDetails({Key? key, required this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(children: <Widget>[
              const Padding(padding: EdgeInsets.fromLTRB(10, 15, 10, 0)),
              BackButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ConsumerDetails(store: store)));
                },
              ),
              const CardWidget(
                titleText: "MR J SMITH",
                price1: "R800",
                price2: "R900",
                details: "info@gmail.com",
                quote: false,
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 9,
                  textStyle: const TextStyle(fontSize: 20),
                  minimumSize: const Size(200, 50),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ConsumerDetails(store: store)),
                  );
                },
                child: const Text("SHORTLIST"),
              ),
            ])),
      ),
    );
  }
}
