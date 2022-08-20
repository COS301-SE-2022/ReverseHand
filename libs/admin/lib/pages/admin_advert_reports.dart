import 'package:admin/widgets/admin_navbar_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:redux_comp/redux_comp.dart';

class AdminAdvertReports extends StatelessWidget {
  final Store<AppState> store;
  const AdminAdvertReports({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              //*******************APP BAR WIDGET*********************//
              AppBarWidget(title: "ADMIN REPORTS", store: store),
              //********************************************************//
            ],
          ),
        ),
        bottomNavigationBar: AdminNavBarWidget(store: store),
      ),
    );
  }
}
