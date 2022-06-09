import 'package:authentication/widgets/button.dart';
import 'package:authentication/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/card.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:general/widgets/tab.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

//Command to run test: flutter test integration_test/login_test.dart
//This integration test goes the Login Route to using the app
void main() {
  //make sure service is initialized first to run on device
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  //Note: When entering text into fields or tapping buttons
  //you have to use the .pumpAndSettel();

  testWidgets("Login And Use App as consumer", (WidgetTester tester) async {
    app.main(); //start the app from the main function
    await tester.pumpAndSettle();

    //storing constants used to login as consumer
    const email = "consumer.cachemoney@gmail.com";
    const passowrd = "Consumer#01";

    //get the widgets to enter text and login button
    var _email = find.widgetWithText(TextFormField, "email");
    expect(_email, findsOneWidget);
    var _password = find.widgetWithText(TextFormField, "password");
    expect(_password, findsOneWidget);
    var login = find.widgetWithText(ElevatedButton, "Login");
    expect(login, findsOneWidget);

    //now entering the values in the fields
    await tester.enterText(_email, email);
    await tester.pumpAndSettle();

    await tester.enterText(_password, passowrd);
    await tester.pumpAndSettle();

    //scrolling a bit
    await tester.dragUntilVisible(
        login, find.byType(Scaffold), const Offset(0.0, 300));
    await tester.pumpAndSettle();

    //now clicking the login button
    await tester.tap(login);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 25), () {});

    //Now on page showing all the adverts.
    var advert = find.widgetWithText(QuickViewJobCardWidget, "Painting");
    expect(advert, findsOneWidget);

    //click on the advert
    await tester.tap(advert);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 3), () {});

    //get the active button
  });
}
