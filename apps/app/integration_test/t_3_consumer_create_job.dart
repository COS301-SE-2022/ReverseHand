import 'package:consumer/widgets/consumer_floating_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

void main() {
  //make sure service is initialized first to run on device
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  //Note: When entering text into fields or tapping buttons
  //you have to use the .pumpAndSettel();

  testWidgets("Create Job As Consumer", (WidgetTester tester) async {
    app.main(); //start the app from the main function
    await tester.pumpAndSettle();

    //storing constants used to login as consumer
    const email = "fiwij93949@orlydns.com";
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

    //**************************************************************** */
    //Homepage
    var plusButton =
        find.widgetWithIcon(ConsumerFloatingButtonWidget, Icons.add);
    expect(plusButton, findsOneWidget);

    //press the add advert button
    await tester.tap(plusButton);
    await tester.pumpAndSettle();

    //**************************************************************** */
    //create a job page

    var title = find.bySemanticsLabel("Title");
    expect(title, findsOneWidget);

    var description = find.bySemanticsLabel("Description");
    expect(description, findsOneWidget);

    var tradeType = find.text("Trade Type");
    expect(tradeType, findsOneWidget);

    //Enter some text into the title
    await tester.enterText(title, "Integration Test");
    await tester.pumpAndSettle();

    //choose a trade type
    await tester.tap(tradeType);
    await tester.pumpAndSettle();

    var painting = find.text("Painting");
    expect(painting, findsOneWidget);

    await tester.tap(painting);
    await tester.pumpAndSettle();

    var submitOne = find.widgetWithText(ButtonWidget, "Submit");
    expect(submitOne, findsOneWidget);

    await tester.tap(submitOne);
    await tester.pumpAndSettle();

    //Enter some text into the Description
    await tester.enterText(description, "Flutter Integration Test");
    await tester.pumpAndSettle();

    //find the create button
    var create = find.widgetWithText(LongButtonWidget, "Create Job");
    expect(create, findsOneWidget);

    //scrolling a bit
    await tester.dragUntilVisible(
        create, find.byType(Scaffold), const Offset(0.0, 300));
    await tester.pumpAndSettle();

    await tester.tap(create);
    await tester.pumpAndSettle();
  });
}

/*
• UC1: View Profile - Done
• UC2: Post Job Advert
• UC3: Leave Review
• UC4: Register
• UC5: Find Jobs
• UC6: Place Bids
• UC7: Notifications
• UC8: Choose Bid
• UC9: View Bids
• UC10: Shortlist Bid
• UC11: Close Job
• UC12: Delete and Edit Adverts
• UC13: Delete and Edit Bids
• UC14: Filter Adverts and Bids
• UC15: Geolocation
• UC16: Upload Quote
• UC17: Chat App
*/
