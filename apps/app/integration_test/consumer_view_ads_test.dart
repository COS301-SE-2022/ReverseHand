import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

//command to run test: flutter test integration_test/consumer_view_ads_test.dart

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("View some created ads", (WidgetTester tester) async {
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
        find.widgetWithText(QuickViewJobCardWidget, "Umhlanga/Tester2");
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

    await Future.delayed(const Duration(seconds: 3), () {});

    //Get the back button Widget
    var backBtn = find.widgetWithText(ButtonWidget, "Back");
    expect(backBtn, findsOneWidget);

    //press the Back Button
    await tester.tap(backBtn);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 3), () {});

    //To add: at least 2 more adverts to view

    var testJobTwo =
        find.widgetWithText(QuickViewJobCardWidget, "Umhlanga/Tester2");
    expect(testJobTwo, findsOneWidget);

    //scrolling a bit
    await tester.dragUntilVisible(
        testJobTwo, find.byType(Scaffold), const Offset(0.0, 300));
    await tester.pumpAndSettle();

    //click on a second advert
    await tester.tap(testJobTwo);
    await tester.pumpAndSettle();
  });
}
