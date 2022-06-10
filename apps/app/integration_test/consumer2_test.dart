import 'package:authentication/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

//this integration test goes though the sign up link, then oops
//I meant to login and uses the sign in link and signs in and visits some adverts

void main() {
  //make sure service is initialized first to run on device
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  //Command: flutter test integration_test/consumer2_test.dart
  testWidgets("2nd Consumer Test", (WidgetTester tester) async {
    app.main(); //start the app from the main function
    await tester.pumpAndSettle();

    //storing constants used to login as consumer
    const emaiL = "consumer.cachemoney@gmail.com";
    const passworD = "Consumer#01";

    //get the sign up widget

    var signUp = find.widgetWithText(GestureDetector, "Sign Up");
    expect(signUp, findsOneWidget);

    //click the signup link
    await tester.tap(signUp);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 15), () {});
    await tester.tapAt(const Offset(0, 0));
    await Future.delayed(const Duration(seconds: 5), () {});

    //find that signup button and press it
    signUp = find.widgetWithText(LongButtonWidget, "Sign Up");
    expect(signUp, findsOneWidget);
    await tester.tap(signUp);
    await tester.pumpAndSettle();

    //Ooops wrong page, want to login. Already have account
    var signIn = find.widgetWithText(GestureDetector, "Sign In");
    expect(signIn, findsOneWidget);
    await Future.delayed(const Duration(seconds: 7), () {});

    //scroll donw a bit
    await tester.dragUntilVisible(
        signIn, find.byType(Scaffold), const Offset(0.0, 300));
    await tester.pumpAndSettle();

    await tester.tap(signIn);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 10), () {});
    await Future.delayed(const Duration(seconds: 3), () {});

    //get the widgets to enter text and login button
    var email_ = find.widgetWithText(TextFormField, "email");
    expect(email_, findsOneWidget);
    var password_ = find.widgetWithText(TextFormField, "password");
    expect(password_, findsOneWidget);
    var login = find.widgetWithText(ElevatedButton, "Login");
    expect(login, findsOneWidget);

    //enter some text into the fields
    await tester.enterText(email_, emaiL);
    await tester.pumpAndSettle();

    await tester.enterText(password_, passworD);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5), () {});

    //scroll a bit
    await tester.dragUntilVisible(
        login, find.byType(Scaffold), const Offset(0.0, 500));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5), () {});

    //click the login button
    await tester.tap(login);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 20), () {});
    await tester.tapAt(const Offset(0, 0));
    await Future.delayed(const Duration(seconds: 10), () {});

    //click the Plumbing advert
    var plumbing = find.widgetWithText(QuickViewJobCardWidget, "Plumbing");
    expect(plumbing, findsOneWidget);

    await tester.tap(plumbing);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 10), () {});
    await tester.tapAt(const Offset(0, 0));
    await Future.delayed(const Duration(seconds: 10), () {});

    //get the active button and other buttons on screen
    var active = find.text("ACTIVE");
    expect(active, findsOneWidget);
    await Future.delayed(const Duration(seconds: 5), () {});
    var shortlist1 = find.text("SHORTLIST");
    expect(shortlist1, findsOneWidget);

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

    //go to previous page
    await tester.pageBack();
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2), () {});

    //find the plus button
    var plusBtn = find.widgetWithText(ElevatedButton, "+");
    expect(plusBtn, findsOneWidget);
    await tester.tap(plusBtn);
    await Future.delayed(const Duration(seconds: 3), () {});

    // var title = find.widgetWithText(TextFieldWidget, "Title");
    var title = find.text("Title");
    expect(title, findsOneWidget);
    // var description = find.widgetWithText(TextFieldWidget, "Description");
    var description = find.text("Description");
    expect(description, findsOneWidget);
  });
}
