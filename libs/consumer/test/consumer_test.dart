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

  testWidgets(("Testing the Job Creation Class"), (WidgetTester tester) async {
    //create an instance of JobCreation
    await tester.pumpWidget(JobCreation(store: store));

    //find the IconButton
    final iconB = find.byType(IconButton);
    //expect to find one IcconButton
    expect(iconB, findsOneWidget);

    //find Text element with Creating a job
    final cJob = find.widgetWithText(Scaffold, "Creating a job");
    expect(cJob, findsOneWidget);

    //verify there is more than one Textfield on the screen
    debugPrint("Verifying there are 4 TextFields to enter input");
    final textf = find.byType(TextField);
    expect(textf, findsNWidgets(4));
    debugPrint("Success: Found more exactly 4 TextFields\n");

    //verify there is a button that says "Add new job"
    debugPrint("Searching for the \"Add New Job\" button");
    final newJob = find.widgetWithText(Scaffold, "Add New Job");
    expect(newJob, findsOneWidget);
    debugPrint("Success: Button to add new job found.\n");

    debugPrint("Locating the Title textfiled");
    final title = find.widgetWithText(Scaffold, "Title");
    expect(title, findsOneWidget);
    debugPrint("Successfully located\n");

    debugPrint("Entering \"Plumbing Job\" in the Title");
    await tester.enterText(find.widgetWithText(TextField, "Title"), "John");
    debugPrint("Successfully Entered Title\n");

    debugPrint("Entering Description");
    await tester.enterText(
        find.widgetWithText(TextField, "Description"), "Toilet is clogged");
    debugPrint("Successfully Entered Description\n");

    debugPrint("Entering Location");
    await tester.enterText(
        find.widgetWithText(TextField, "Location"), "Pretoria");
    debugPrint("Successfully Entered Location\n");

    debugPrint("Entering the date");
    await tester.enterText(
        find.widgetWithText(TextField, "Date"), "2020.05.12");
    debugPrint("Successfully Entered Date\n");

    debugPrint("Clicking button to create job");
    await tester.press(newJob);
    debugPrint("Job Successfully created\n");
  });
}
