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

    // final icons = find.byType(Icon);
    // expect(icons, findsWidgets); //expect to find one or more listings

    //attempt to click an advert

    final scaffhold = find.byType(Scaffold);

    // get the appbar
    final appbar =
        find.descendant(of: scaffhold, matching: find.byType(AppBar));
    expect(appbar, findsOneWidget);

    //get the text of the appbar
    final appText = find.descendant(of: appbar, matching: find.byType(Text));
    expect(appText, findsOneWidget); //expect one title in appbar

    // final des = find.byType(ListTile);
    // expect(des, findsWidgets); //should find more than one title widget

    //find the body
    // final body =
    //     find.descendant(of: scaffhold, matching: find.byType(ListView));

    // expect(body, findsOneWidget);

    // //get the InkWell
    // final ink = find.descendant(of: body, matching: find.byType(InkWell));
    // expect(ink, findsWidgets);
  });

/*
  testWidgets("Widget test for Consumer Details", (WidgetTester tester) async {
    //setting up the ConsumerDetails widget
    await tester.pumpWidget(ConsumerDetails(store: store));

    final scaffhold = find.byType(Scaffold);
    expect(scaffhold, findsOneWidget);

    //find the back button
    final iconButton =
        find.descendant(of: scaffhold, matching: find.byType(IconButton));
    expect(iconButton, findsOneWidget);

    //find the row element
    final row = find.descendant(of: scaffhold, matching: find.byType(Row));
    expect(row, findsOneWidget);

    //check for description
    final desc = find.descendant(of: row, matching: find.text("Description"));
    expect(desc, findsOneWidget);
  });
*/
}
