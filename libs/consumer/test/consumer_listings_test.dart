import 'package:async_redux/async_redux.dart';
import 'package:consumer/consumer.dart';
import 'package:consumer/widgets/consumer_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/general.dart';
import 'package:general/widgets/appbar.dart';
import 'package:redux_comp/redux_comp.dart';

void main() {
  var store = Store<AppState>(initialState: AppState.initial());

  final navigatorKey = GlobalKey<NavigatorState>();

  final widget = StoreProvider(
      store: store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        initialRoute: '/consumer',
        navigatorKey: navigatorKey,
        routes: {
          // consumer routes
          '/consumer': (context) => ConsumerListingsPage(store: store),
          '/consumer/create_advert': (context) =>
              CreateNewAdvertPage(store: store),
        },
      ));

  testWidgets("Consumer Listings", (WidgetTester tester) async {
    await tester.pumpWidget(widget);

    //App bar widget
    final pageTitle = find.widgetWithText(AppBarWidget, "MY JOBS");
    expect(pageTitle, findsOneWidget);

    //tab bar labels
    final openTab = find.widgetWithText(TabBar, "OPEN");
    expect(openTab, findsOneWidget);

    final progressTab = find.widgetWithText(TabBar, "IN PROGRESS");
    expect(progressTab, findsOneWidget);

    //tab bar functionality
    final defaultMessageOne = find.widgetWithText(SingleChildScrollView,
        "You do not have any active jobs. Create a new job to see it here and enable contractors to start bidding.");
    expect(defaultMessageOne, findsOneWidget);

    //press the in progress thingy
    await tester.tap(progressTab);
    await tester.pumpAndSettle();

    final defaultMessageTwo = find.widgetWithText(SingleChildScrollView,
        "No jobs are currently in progress. Only jobs with accepted bids are displayed here.");
    expect(defaultMessageTwo, findsOneWidget);

    //navbar
    final plusButton =
        find.widgetWithIcon(ConsumerFloatingButtonWidget, Icons.add);
    expect(plusButton, findsOneWidget);

    //press the create advert button
    await tester.tap(plusButton);
    await tester.pumpAndSettle();
  });
}
