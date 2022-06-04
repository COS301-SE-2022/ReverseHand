import 'package:async_redux/async_redux.dart';
import 'package:consumer/consumer.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

import 'package:general/widgets/card.dart';
import 'package:general/widgets/button.dart';

class ShortListBidDetails extends StatelessWidget {
  final Store<AppState> store;
  const ShortListBidDetails({Key? key, required this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(
            backgroundColor: const Color.fromRGBO(18, 26, 34, 1),
            body: Column(children: <Widget>[
              const Padding(
                padding: const EdgeInsets.all(20),
              ),
              const CardWidget(
                titleText: "MR J SMITH",
                price1: "R800",
                price2: "R900",
                details: "info@gmail.com",
                quote: true,
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
                        builder: (_) => ConsumerListings(store: store)),
                  );
                },
                child: const Text("ACCEPT"),
              ),
            ])),
      ),
    );
  }
}
