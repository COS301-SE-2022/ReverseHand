import 'package:amplify/amplify.dart';
import 'package:amplify/models/Advert.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

import '../pages/create_new_job.dart';
import '../pages/job_details.dart';
import 'package:general/widgets/card.dart';
import 'package:general/widgets/button.dart';

class BidDetails extends StatelessWidget {
  Store<AppState> store;
  BidDetails({Key? key, required this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        home: Scaffold(
            backgroundColor: const Color.fromRGBO(18, 26, 34, 1),
            body: Column(children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(20),
              ),
              CardWidget("TESTING"),
              const Padding(padding: EdgeInsets.all(10)),
              const ButtonWidget()
            ])),
      ),
    );
  }
}
