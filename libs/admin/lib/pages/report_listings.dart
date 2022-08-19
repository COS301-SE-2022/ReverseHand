import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:redux_comp/redux_comp.dart';

class ReportListings extends StatelessWidget {
  final Store<AppState> store;
  const ReportListings({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
          body: Column(children: [
        //*******************APP BAR WIDGET*********************//
        AppBarWidget(title: "ADMIN REPORTS", store: store),
        //********************************************************//
      ])),
    );
  }
}
