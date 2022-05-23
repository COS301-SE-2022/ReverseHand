import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

import 'package:general/widgets/card.dart';
import 'package:general/widgets/divider.dart';

class Bids extends StatelessWidget {
  final Store<AppState> store;
  const Bids({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(
            // appBar: AppBar(
            //   title: const Text('Bid'),
            // ),
            backgroundColor: const Color.fromRGBO(18, 26, 34, 1),
            body: Column(children: const <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
              ),
              CardWidget(),
              DividerWidget(),
            ])),
      ),
    );
  }
}
