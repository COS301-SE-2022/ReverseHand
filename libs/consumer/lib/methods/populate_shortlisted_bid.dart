import 'package:async_redux/async_redux.dart';
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
            body: Column(children: const <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
              ),
              CardWidget(
                titleText: "MR J SMITH",
                price1: "R800",
                price2: "R900",
                details: "info@gmail.com",
                quote: true,
              ),
              Padding(padding: EdgeInsets.all(10)),
              ButtonWidget(
                text: "ACCEPT",
              )
            ])),
      ),
    );
  }
}
