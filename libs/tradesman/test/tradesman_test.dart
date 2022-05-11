import 'package:flutter_test/flutter_test.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:tradesman/tradesman.dart';

void main() {
  //Create a store to use for the various states
  final store = Store<AppState>(initialState: AppState.mock());

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
}
