import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

//Command to run test: flutter test integration_test/login_test.dart
//This integration test goes the Login Route to using the app
void main() {
  //make sure service is initialized first to run on device
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  //Note: When entering text into fields or tapping buttons
  //you have to use the .pumpAndSettel();

  testWidgets("Login as a  Consumer", (WidgetTester tester) async {
    app.main(); //start the app from the main function
    await tester.pumpAndSettle();

    //storing constants used to login as consumer
    const email = "consumer.cachemoney@gmail.com";
    // const email = "lastrucci61@gmail.com";
    const passowrd = "Consumer#01";
    // const passowrd = "@Aa12345";

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
    await Future.delayed(const Duration(seconds: 20), () {});
    await tester.tap(login);

    await Future.delayed(const Duration(seconds: 15), () {});
    //await tester.tap(login);

    await Future.delayed(const Duration(seconds: 6), () {});

    /*//Now on page showing all the adverts.
    var advert = find.widgetWithText(QuickViewJobCardWidget, "Painting");
    expect(advert, findsOneWidget);

    await Future.delayed(const Duration(seconds: 6), () {});

    //click on the advert
    await tester.tap(advert);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 20), () {});

    debugPrint("clicking advert for the 2nd time");
    await tester.dragUntilVisible(
        advert, find.byType(Scaffold), const Offset(0.0, 300));
    await tester.pumpAndSettle();

    //await tester.tap(advert);
    //await tester.pumpAndSettle();
    //await Future.delayed(const Duration(seconds: 2), () {});

    //get the active button and other buttons on screen
    // var active = find.widgetWithText(TabWidget, "ACTIVE");
    var active = find.text("ACTIVE");
    expect(active, findsOneWidget);
    await Future.delayed(const Duration(seconds: 5), () {});

    // var shortlist1 = find.widgetWithText(TabWidget, "SHORTLIST");
    var shortlist1 = find.text("SHORTLIST");
    expect(shortlist1, findsOneWidget);
    // var bid0 = find.widgetWithText(QuickViewBidWidget, "Bid 0");
    //var bid0 = find.text("Bid 0");
    //expect(bid0, findsOneWidget);

    //press some buttons to demonstrate they work
    await tester.tap(active); //deactivate
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1), () {});

    await tester.tap(active); //activate
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1), () {});

    await tester.tap(shortlist1); //activate
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1), () {});

    await tester.tap(shortlist1); //deactivate
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1), () {});

    //tap the Bid 0
    //await tester.tap(bid0);
    //await tester.pumpAndSettle();
    //await Future.delayed(const Duration(seconds: 2), () {});

    //click the shortlist button
    //await tester.tap(shortlist1);
    //await tester.pumpAndSettle();
    //await Future.delayed(const Duration(seconds: 2), () {});

    //go back to the last page
    await tester.pageBack();
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2), () {});*/
  });
}
