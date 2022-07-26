import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("View and accept bid", (WidgetTester tester) async {
    //start the app from main.dart
    app.main();
    await tester.pumpAndSettle();

    //constants for login
    const email = "lastrucci61@gmail.com";
    //const email = "consumer.cachemoney@gmail.com";
    //const passowrd = "Consumer#01";
    const passowrd = "@Aa12345";

    //get the widgets to enter the text
    var email_ = find.widgetWithText(TextFormField, "email");
    expect(email_, findsOneWidget);
    var password_ = find.widgetWithText(TextFormField, "password");
    expect(password_, findsOneWidget);

    //get the login button
    var login = find.widgetWithText(ElevatedButton, "Login");
    expect(login, findsOneWidget);

    //now entering the values in the fields
    await tester.enterText(email_, email);
    await tester.pumpAndSettle();

    await tester.enterText(password_, passowrd);
    await tester.pumpAndSettle();

    //scroll down a bit
    await tester.dragUntilVisible(
        login, find.byType(Scaffold), const Offset(0.0, 300));
    await tester.pumpAndSettle();

    //press the login button
    await tester.tap(login);
    await tester.pumpAndSettle();
    //await Future.delayed(const Duration(seconds: 20), () {});//reduce seconds if using ios device/laptop
    await Future.delayed(const Duration(seconds: 6),
        () {}); //reduce seconds if using ios device/laptop
    await tester.tap(login, warnIfMissed: false);
    await tester.pumpAndSettle();

    //await Future.delayed(const Duration(seconds: 15), () {});
    await Future.delayed(const Duration(seconds: 2), () {});

    //------------------------------------------------------------//
    //Now on page showing Adverts
    var painting = find.widgetWithText(QuickViewJobCardWidget, "Painting");
    expect(painting, findsOneWidget);

    //click on the advert
    await tester.tap(painting);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5), () {});

    await tester.tap(painting, warnIfMissed: false);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 5), () {});

    //Get the View Bids Button
    var viewBids = find.widgetWithText(ButtonWidget, "View Bids");
    expect(viewBids, findsOneWidget);

    //click the view bids button
    await tester.tap(viewBids);
    await tester.pumpAndSettle();

    //--------------------------------------------------------------------
    //View bids page

    var bidName = "BidName"; //change this later. *****************************
    //select one of the bids
    var bid = find.widgetWithText(QuickViewJobCardWidget, bidName);
    expect(bid, findsOneWidget);

    //press the bid
    await tester.tap(bid);
    await tester.pumpAndSettle();

    //--------------------------------------------------------------
    //Bid details card/page where there is shortlist button or accept button

    //For now only shortlist a bid
    var shortListBtn = find.widgetWithText(ElevatedButton, "ShortList Bid");
    expect(shortListBtn, findsOneWidget);

    //Press the button
    await tester.tap(shortListBtn);
    await tester.pumpAndSettle();

    //------------------------------------------------------------------
    //popup which says are you sure you want to shortlist this bid
  });
}
