import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

//Command to run test: flutter test integration_test/1_consumer_login.dart
//This integration test goes the Login Route to using the app
void main() {
  //make sure service is initialized first to run on device
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  //Note: When entering text into fields or tapping buttons
  //you have to use the .pumpAndSettel();

  testWidgets("Login as a  Consumer", (WidgetTester tester) async {
    app.main(); //start the app from the main function
    await tester.pumpAndSettle();

    //storing constants used to login as tradesman
    const email = "yojeja5123@edxplus.com";
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

    ////////////////////////////////////////////////////////////////
    //Job Listings Page

    var jobOne = find.text("Integration Test");
    expect(jobOne, findsOneWidget);

    await tester.tap(jobOne);
    await tester.pumpAndSettle();

    //////////////////////////////////////////////////////////////
    //Job Info Page

    var placeBid = find.text("Place Bid");
    expect(placeBid, findsOneWidget);

    await tester.tap(placeBid);
    await tester.pumpAndSettle();

    var proceedBtn = find.text("Proceed");
    expect(proceedBtn, findsOneWidget);

    await tester.tap(proceedBtn);
    await tester.pumpAndSettle();

    //Step 2 for entering amount
    var form = find.byType(TextFormField);
    expect(form, findsOneWidget);

    await tester.enterText(form, "1000");
    await tester.pumpAndSettle();

    await tester.tap(find.text("Submit Bid"));
    await tester.pumpAndSettle();
/*
    //var workBtn = find.widgetWithIcon(IconButton, Icons.work);
    //expect(workBtn, findsOneWidget);

    //await tester.tap(workBtn);
    //await tester.pumpAndSettle();

    //await tester.tap(find.text("MY BIDS")); //go to your bids
    //await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 3), () {});

    //await tester.tap(find.text("OPEN JOBS"));
    //await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 1), () {});

    //await tester.tap(find.text("MY BIDS")); //go to your bids
    //await tester.pumpAndSettle();
    var workBtn = find.widgetWithIcon(IconButton, Icons.work);
    expect(workBtn, findsOneWidget);

    await tester.tap(workBtn);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 3), () {});

    //await tester.tap(find.text("Integration Test"));
    //await tester.pumpAndSettle();

    /////////////////////////////////////////////////////////////////
    //Edit bid

    await tester.tap(find.bySemanticsLabel("Click on your bid to edit it"));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byType(TextFormField), "1200"); //enter new amount
    await tester.pumpAndSettle();

    await tester.tap(find.text("Save"));
    await tester.pumpAndSettle();
    */
  });
}

//**  Do not delete this list **
//1. Login
//2. view ads
//3. filter bids
//4. view and bid and shortlist/accept it
//5. edit an advert
//6. create a job
