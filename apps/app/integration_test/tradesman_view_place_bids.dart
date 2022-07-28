import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("View and place bid Tradesman", (WidgetTester tester) async {
    app.main(); //start the app from the main function
    await tester.pumpAndSettle();

    //storing constants used to login as consumer
    const email = "tradesman.cachemoney@gmail.com";
    const passowrd = "@Aa12345";

    //get the widgets to enter text and login button
    var email_ = find.widgetWithText(TextFormField, "email");
    expect(email_, findsOneWidget);
    var password_ = find.widgetWithText(TextFormField, "password");
    expect(password_, findsOneWidget);
    var login = find.widgetWithText(ElevatedButton, "Login");
    expect(login, findsOneWidget);

    //now entering the values in the fields
    await tester.enterText(email_, email);
    await tester.pumpAndSettle();

    await tester.enterText(password_, passowrd);
    await tester.pumpAndSettle();

    //scrolling a bit
    await tester.dragUntilVisible(
        login, find.byType(Scaffold), const Offset(0.0, 300));
    await tester.pumpAndSettle();

    //now clicking the login button
    await tester.tap(login);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 3), () {});

    //-----------------------------------------------------------------------
    //Job listings Page

    //get the work icon
    var briefCase = find.widgetWithIcon(IconButton, Icons.work);
    expect(briefCase, findsOneWidget);
    //press the work icon
    await tester.tap(briefCase);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 3), () {});

    //get the job widget
    var jobOne =
        find.widgetWithText(QuickViewJobCardWidget, "Integration Test Job v2");
    expect(jobOne, findsOneWidget);

    //scrolling a bit
    await tester.dragUntilVisible(
        jobOne, find.byType(Scaffold), const Offset(0.0, 300));
    await tester.pumpAndSettle();

    //press the advert/job
    await tester.tap(jobOne);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 5), () {});
    await tester.tap(jobOne, warnIfMissed: false);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5), () {});

    //Get the view bids button
    var viewBids = find.widgetWithText(ButtonWidget, "View Bids");
    expect(viewBids, findsOneWidget);

    //click the view bids button
    await tester.tap(viewBids);
    await tester.pumpAndSettle();

    //get the Back Button
    var backBtn = find.widgetWithText(ButtonWidget, "Back");
    expect(backBtn, findsOneWidget);
    //press the back button
    await tester.tap(backBtn);
    await tester.pumpAndSettle();

    //get the Place Bid button
    var placeBidBtn = find.widgetWithText(ButtonWidget, "Place Bid");
    expect(placeBidBtn, findsOneWidget);

    //press the place Bid button
    await tester.tap(placeBidBtn);
    await tester.pumpAndSettle();

    //adjust the scroll thing: too complicated to do now.

    //press the cancel button because dont want to place a bid each time
    var cancel = find.widgetWithText(TextButton, "Cancel");
    expect(cancel, findsOneWidget);

    await tester.tap(cancel);
    await tester.pumpAndSettle();
    //integration test  runs
  });
}

//useful command: await tester.drag(find.byType(Slider), Offset(100, 0));