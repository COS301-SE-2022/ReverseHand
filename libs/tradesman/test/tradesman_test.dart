import 'package:flutter_test/flutter_test.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:tradesman/tradesman.dart';

void main() {
  //test for TradesmanJobListings
  testWidgets("Testing TradesmanJobListings class",
      (WidgetTester tester) async {
    final store = Store<AppState>(initialState: AppState.mock());

    await tester.pumpWidget(TradesmanJobListings(store: store));

    //find exactly one scaffold widget
    var scaff = find.byType(Scaffold);
    expect(scaff, findsOneWidget);

    //find one appbar
    var appbar = find.descendant(of: scaff, matching: find.byType(AppBar));
    expect(appbar, findsOneWidget);

    //find exactly one Job Listings Text
    var text = find.text("Job Listings");
    expect(text, findsOneWidget);

    var list = find.descendant(of: scaff, matching: find.byType(ListView));
    expect(list, findsOneWidget);
  });

  testWidgets("Testing the TradesmanJobDetails class",
      (WidgetTester tester) async {
    //final store = Store<AppState>(initialState: AppState.mock());
    //await tester.pumpWidget(TradesmanJobDetails(store: store, advert: null,));
  
    //expect to find exactly one description in a job
    expect(find.widgetWithText(Scaffold, 'Description'), findsOneWidget);

    //expect to find one or more bids
    // expect(find.widgetWithText(Scaffold, "Bids"), findsWidgets);

    //expect to find 1 info Text being displayed
    expect(find.widgetWithText(Scaffold, "Info"), findsOneWidget);

    var scaff = find.byType(Scaffold);
    expect(scaff, findsOneWidget);

    //expect to find one IconButton i.e the back button
    var icon = find.descendant(of: scaff, matching: find.byType(IconButton));
    expect(icon, findsOneWidget);
  });
}
