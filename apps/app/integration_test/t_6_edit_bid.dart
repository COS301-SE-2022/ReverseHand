import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/user_bid_details_widget.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

//Command to run test: flutter test integration_test/1_consumer_login.dart
//This integration test goes the Login Route to using the app
void main() {
  //make sure service is initialized first to run on device
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  //Note: When entering text into fields or tapping buttons
  //you have to use the .pumpAndSettel();

  testWidgets("Tradesman Edit Bid", (WidgetTester tester) async {
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

    await tester.tap(find.text("MY BIDS")); //go to your bids
    await tester.pumpAndSettle();

    await tester.tap(find.text("Integration Test"));
    await tester.pumpAndSettle();
    /////////////////////////////////////////////////////////////////
    //Edit bid
    await Future.delayed(const Duration(seconds: 3), () {});

    // await tester.tap(find.bySemanticsLabel("Click on your bid to edit it"));
    await tester.tap(find.byType(UserBidDetailsWidget));
    await tester.pumpAndSettle();

    await tester.enterText(
        find.byType(TextFormField), "1200"); //enter new amount
    await tester.pumpAndSettle();

    await tester.tap(find.text("Save"));
    await tester.pumpAndSettle();
  });
}
