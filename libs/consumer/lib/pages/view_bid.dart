import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

import 'package:general/widgets/card.dart';

class Bids extends StatelessWidget {
  final Store<AppState> store;
  const Bids({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Bid'),
            backgroundColor: const Color.fromRGBO(82, 121, 111, 1),
          ),
          body: const CardWidget(),
        ),
      ),
    );
  }
}
