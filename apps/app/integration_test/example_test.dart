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

    //Get the painting Adverts
    var painting = find.widgetWithText(QuickViewJobCardWidget, "Painting");
    expect(painting, findsOneWidget);

    //click on the advert
    await tester.tap(painting);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5), () {});

    await tester.tap(painting, warnIfMissed: false);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 5), () {});

    //Get the back button Widget
    var backBtn = find.widgetWithText(ButtonWidget, "Back");
    expect(backBtn, findsOneWidget);

    //press the Back Button
    await tester.tap(backBtn);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5), () {});

    //To add: at least 2 more adverts to view
  });
}
