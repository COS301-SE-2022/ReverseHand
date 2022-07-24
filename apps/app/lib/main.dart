import 'package:async_redux/async_redux.dart';
import 'package:authentication/authentication.dart';
import 'package:consumer/consumer.dart';
import 'package:consumer/pages/advert_details_page.dart';
import 'package:consumer/pages/bid_details_page.dart';
import 'package:consumer/pages/consumer_profile_page.dart';
import 'package:consumer/pages/edit_advert_page.dart';
import 'package:consumer/pages/edit_profile_page.dart';
import 'package:consumer/pages/view_bids_page.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:tradesman/pages/activity_stream_page.dart';
import 'package:tradesman/pages/edit_bids_page.dart';
import 'package:tradesman/pages/domain_confirmation_page.dart';
import 'package:tradesman/pages/edit_profile_page.dart';
import 'package:tradesman/pages/tradesman_profile_page.dart';
import 'package:tradesman/pages/view_bids_page.dart';
import 'package:tradesman/pages/location_confirm_page.dart';
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
          // consumer routes
          '/consumer': (context) => ConsumerListingsPage(store: store),
          '/consumer/create_advert': (context) =>
              CreateNewAdvertPage(store: store),
          '/consumer/advert_details': (context) =>
              AdvertDetailsPage(store: store),
          '/consumer/advert_details/bid_details': (context) =>
              BidDetailsPage(store: store),
          '/consumer/consumer_profile_page': (context) =>
              ConsumerProfilePage(store: store),
          '/consumer/edit_profile_page': (context) =>
              EditProfilePage(store: store),
          '/consumer/view_bids': (context) => ViewBidsPage(store: store),
          '/consumer/edit_advert_page': (context) =>
              EditAdvertPage(store: store),
          // tradesman routes
          '/tradesman': (context) => TradesmanJobListings(store: store),
          '/tradesman/advert_details': (context) =>
              TradesmanJobDetails(store: store),
          '/tradesman/profile': (context) =>
              TradesmanProfilePage(store: store),
          '/tradesman/edit_profile_page': (context) =>
              EditTradesmanProfilePage(store: store),
          '/tradesman/view_bids_page': (context) => TradesmanViewBidsPage(store: store),
          '/tradesman/advert_details/edit_bid': (context) =>
              EditBidsPage(store: store),
          '/tradesman/activity_stream': (context) =>
              ActivityStream(store: store),
          '/tradesman/location_confirm': (context) =>
              LocationConfirmPage(store: store),
          '/tradesman/domain_confirm': (context) =>
              DomainConfirmPage(store: store),
          '/tradesman/view_bids': (context) =>
              TradesmanViewBidsPage(store: store),
          // authentication routes
          '/signup': (context) => SignUpPage(store: store),
          '/login': (context) => LoginPage(store: store),
        },
      ),
    );
  }
}
