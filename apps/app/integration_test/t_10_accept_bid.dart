import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Accept Bid", (WidgetTester tester) async {
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

    await tester.tap(find.text("Integration Test")); //click advert
    await tester.pumpAndSettle();

    await tester.tap(find.text("View Bids (1)"));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Peter"));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Accept Bid")); //click the accept button
    await tester.pumpAndSettle();

    await tester.tap(find.text("Accept"));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 3), () {});

    await tester.enterText(
        find.widgetWithText(TextFormField, "CARD NUMBER"), "4084084084084081");
    await tester.pumpAndSettle();

    await tester.enterText(
        find.widgetWithText(TextFormField, "CARD EXPIRY"), "09/23");
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextFormField, "CVV"), "408");
    await tester.pumpAndSettle();

    await tester.tap(find.text("Pay ZAR 1,200.00"));
    await tester.pumpAndSettle();
  });
}
