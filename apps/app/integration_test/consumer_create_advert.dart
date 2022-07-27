import 'package:authentication/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/floating_button.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Create Advert Integration Test", (WidgetTester tester) async {
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

    //get that orange add button on the screen.
    var addAdvert = find.widgetWithIcon(FloatingButtonWidget, Icons.add);
    expect(addAdvert, findsOneWidget);

    //press that button add button
    await tester.tap(addAdvert);
    await tester.pumpAndSettle();

    //---------------------------------------------------------------
    //Create a Job page.

    //Get the title and description widgets
    var tTitle = find.widgetWithText(TextFieldWidget, "Title");
    expect(tTitle, findsOneWidget);

    var dDescription = find.widgetWithText(TextFieldWidget, "Description");
    expect(dDescription, findsOneWidget);

    //Enter some text into the title
    await tester.enterText(tTitle, "The Title");
    await tester.pumpAndSettle();

    //Enter some text into the Description
    await tester.enterText(dDescription, "This is a description");
    await tester.pumpAndSettle();

    //Get the Discard Button
    var discard = find.widgetWithText(ButtonWidget, "Discard");
    expect(discard, findsOneWidget);

    //press the Discard Button not create because it will end up creating too
    //many jobs everytime pipeline runs.

    await tester.tap(discard);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 2), () {});
  });
}
