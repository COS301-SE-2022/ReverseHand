import 'package:authentication/widgets/button.dart';
import 'package:authentication/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/card.dart';
import 'package:general/widgets/tab.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

//This integration test goes the Login Route to using the app
void main() {
  //make sure service is initialized first to run on device
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Login And Use App", (WidgetTester tester) async {
    app.main(); //start the app from the main function
    await tester.pumpAndSettle();

    //landing page is the login page
    const email = "cachemoney.up@gmail.com";
    const password = "password123";

    //storing important fields from the login page in variables
    var emailField = find.widgetWithText(TextFieldWidget, "email");
    expect(emailField, findsOneWidget); //find one such field
    var passwordField = find.widgetWithText(TextFieldWidget, "password");
    expect(passwordField, findsOneWidget);
    var loginButton = find.widgetWithText(LongButtonWidget, "login");
    expect(loginButton, findsOneWidget);

    //Note: await tester.pumpAndSettle is required after any form of
    //clicking, tapping, entering text, scrolling etc

    //entering the email into the field
    await tester.enterText(emailField, email);
    await tester.pumpAndSettle();
    //enterig the password into the field
    await tester.enterText(passwordField, password);
    await tester.pumpAndSettle();
    //press the login button
    await tester.press(loginButton);
    await tester.pumpAndSettle();

    //Consumer Page starts here
    var bidCard =
        find.widgetWithText(CardWidget, "PAINTING"); //get one of the bids
    expect(bidCard, findsOneWidget);

    await tester.tap(bidCard); //tap the bid to open it
    await tester.pumpAndSettle();

    //now should see active, shortlist and a name
    var active = find.widgetWithText(TabWidget, "ACTIVE");
    var shortList = find.widgetWithText(TabWidget, "SHORTLIST");
    var tradesmanName =
        find.text("Mr J Smith"); //this has to be updated as its hard coded
    expect(tradesmanName, findsOneWidget);

    //pressing the active and shortlist buttons to deactivate them
    await tester.tap(active);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 3), () {});

    await tester.tap(shortList);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2), () {});

    //now activating those buttons again
    await tester.tap(active);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2), () {});

    await tester.tap(shortList);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2), () {});

    //viewing one of the tradesman that bid
    await tester.tap(tradesmanName);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5), () {});

    //shortlist the selected tradesman
    var shortlistT = find.widgetWithText(ElevatedButton, "SHORTLIST");
    expect(shortlistT, findsOneWidget);
    await tester.tap(shortlistT);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2), () {});
  });
}
