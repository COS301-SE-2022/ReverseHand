import 'package:async_redux/async_redux.dart';
import 'package:consumer/consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/redux_comp.dart';

void main() {
  final store = Store<AppState>(initialState: AppState.mock());

  testWidgets("Testing Title from ConsumerListings",
      (WidgetTester tester) async {
    //creating the ConsumerListings widget
    await tester.pumpWidget(ConsumerListings(store: store));

    //find the Title widget
    final titleFinder = find.text("My Job Listings");
    expect(titleFinder, findsOneWidget); //expect to find one such title

    //find the scaffhold
    final scaff = find.byType(Scaffold);
    //epxect to find exactly one Scaffold
    expect(scaff, findsOneWidget);

    //AppBar must be a descendant of the Scaffhold
    final _appbar = find.descendant(of: scaff, matching: find.byType(AppBar));
    //expect to find exactly one appbar
    expect(_appbar, findsOneWidget);
  });
}
