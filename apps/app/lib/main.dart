import 'package:async_redux/async_redux.dart';
import 'package:authentication/authentication.dart';
import 'package:consumer/pages/job_listings.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:tradesman/tradesman.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  NavigateAction.setNavigatorKey(navigatorKey);

  // acts as main function
  runApp(
    Launch(
      store: Store<AppState>(
        initialState: AppState.initial(),
      ),
    ),
  );
}

class Launch extends StatelessWidget {
  final Store<AppState> store;

  const Launch({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        initialRoute: '/',
        navigatorKey: navigatorKey,
        // defining what routes look like
        routes: {
          '/': (context) => LoginPage(
                store: store,
              ),
          '/consumer': (context) => ConsumerListings(store: store),
          '/tradesman': (context) => TradesmanJobListings(store: store),
          '/signup': (context) => SignUpPage(store: store),
        },
      ),
    );
  }
}
