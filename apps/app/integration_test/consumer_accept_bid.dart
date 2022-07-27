import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

//flutter test integration_test/consumer_accept_bid.dart

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("View and accept bid", (WidgetTester tester) async {
    app.main(); //start the app from the main function
    await tester.pumpAndSettle();

    //storing constants used to login as consumer
    const email = "consumer.cachemoney@gmail.com";
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
    //------------------------------------------------------------//
    //Now on page showing Adverts
    //Get the "Integration Test Job"
    var testJobOne =
        find.widgetWithText(QuickViewJobCardWidget, "Integration Test Job v2");
    expect(testJobOne, findsOneWidget);

    //scrolling a bit
    await tester.dragUntilVisible(
        testJobOne, find.byType(Scaffold), const Offset(0.0, 300));
    await tester.pumpAndSettle();

    //click on the advert
    await tester.tap(testJobOne);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5), () {});

    await tester.tap(testJobOne, warnIfMissed: false);
    await tester.pumpAndSettle();

    //Get the View Bids Button
    var viewBids = find.widgetWithText(ButtonWidget, "View Bids");
    expect(viewBids, findsOneWidget);

    //click the view bids button
    await tester.tap(viewBids);
    await tester.pumpAndSettle();

    //--------------------------------------------------------------------
    //View bids page

    var bidName =
        "R300-R2700"; //change this later. *****************************
    //select one of the bids
    var bid = find.widgetWithText(SizedBox, bidName);
    expect(bid, findsOneWidget);

    //press the bid
    await tester.tap(bid);
    await tester.pumpAndSettle();

    //--------------------------------------------------------------
    //Bid details card/page where there is shortlist button or accept button

    //For now only shortlist a bid
    var shortListBtn = find.widgetWithText(ElevatedButton, "Shortlist Bid");
    expect(shortListBtn, findsOneWidget);

    //Press the button
    await tester.tap(shortListBtn);
    await tester.pumpAndSettle();

    //------------------------------------------------------------------
    //popup which says are you sure you want to shortlist this bid
  });
}
