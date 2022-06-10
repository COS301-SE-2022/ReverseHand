import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

void main() {
  //make sure service is initialized first to run on device
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  //Command: flutter test integration_test/tradesman_login_test.dart

  testWidgets("Tradesman logging in route", (WidgetTester tester) async {
    app.main(); //start the app from the main function
    await tester.pumpAndSettle();

    //storing constants used to login as consumer
    const emaiL = "tradesman.cachemoney@gmail.com";
    const passworD = "Tradesman#01";

    //get the widgets to enter text and login button
    var email_ = find.widgetWithText(TextFormField, "email");
    expect(email_, findsOneWidget);
    var password_ = find.widgetWithText(TextFormField, "password");
    expect(password_, findsOneWidget);
    var login = find.widgetWithText(ElevatedButton, "Login");
    expect(login, findsOneWidget);

    //login as a tradesman
    await tester.enterText(email_, emaiL);
    await tester.pumpAndSettle();

    await tester.enterText(password_, passworD);
    await tester.pumpAndSettle();

    //scrolling a bit
    await tester.dragUntilVisible(
        login, find.byType(Scaffold), const Offset(0.0, 300));
    await tester.pumpAndSettle();

    //login now
    await tester.tap(login);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5), () {});
    await tester.tapAt(const Offset(0, 0));
    await Future.delayed(const Duration(seconds: 5), () {});

    //click on the Plumbing advert
    var plumbing = find.widgetWithText(QuickViewJobCardWidget, "Plumbing");
    expect(plumbing, findsOneWidget);

    await tester.tap(plumbing);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5), () {});
    await tester.tapAt(const Offset(0, 0));
    await Future.delayed(const Duration(seconds: 5), () {});

    //get that place bid button
    var placeBidBtn = find.widgetWithText(ButtonWidget, "Place Bid");
    expect(placeBidBtn, findsOneWidget);

    await tester.tap(placeBidBtn);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5), () {});
    await tester.tapAt(const Offset(0, 0));

    //try and adjust that slider for the price
    await tester.tapAt(const Offset(0, 0));
    await tester.drag(find.byType(RangeSlider), const Offset(50, 0));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5), () {});

    //close the pop up
    await tester.pageBack();
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5), () {});

    //try and filter by location based on a certain radius to tradesman
    var filter = find.widgetWithText(ElevatedButton, "Filter");
    expect(filter, findsOneWidget);
    await tester.tap(filter);
    await tester.pumpAndSettle();

    //log out
    var logout = find.widgetWithText(ElevatedButton, "Log Out");
    await tester.tap(logout);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5), () {});
  });
}
