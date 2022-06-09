import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

//Example of command to run integration test in apps/app
//flutter test integration_test/example_test.dart
//NB: emulator must be running before hand

void main() {
  //make sure service is initialized first to run on device
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("press signUp", (WidgetTester tester) async {
    app.main(); //start the app from the main function
    await tester.pumpAndSettle();
    debugPrint("passed main starting");

    final signUp = find.widgetWithText(GestureDetector, "Sign Up");
    expect(signUp, findsOneWidget);

    await tester.dragUntilVisible(
        signUp, find.byType(Scaffold), const Offset(0.0, 300));
    await tester.pumpAndSettle();

    //press the sign up text and proceed to the signup page
    await tester.tap(signUp);
    await tester.pumpAndSettle();
  });
  /*testWidgets("Login And Use App", (WidgetTester tester) async {
      app.main(); //start the app from the main function
      await tester.pumpAndSettle();

      //storing important widgets from Login Page in variables
      var loginBtn = find.widgetWithText(ElevatedButton, "Login");
      expect(loginBtn, findsOneWidget);
      var email = find.widgetWithText(TextFormField, "email");
      expect(email, findsOneWidget);
      var password = find.widgetWithText(TextFormField, "password");
      expect(password, findsOneWidget);

      String validEmail = "";
      String incorrectEmail = "";
      String validPassword = "";
      String incorrectPassword = "";

      //0: Just click login with nothing entered and that should fail
      tester.press(loginBtn); //attempt to press login button

      //1:Enter correct email and then wrong password. Expect Failure
      await tester.enterText(email, validEmail);
      await tester.enterText(password, incorrectPassword);
      tester.press(loginBtn); //attemp to login with wrong credentials

      //2: Enter wrong email and then "correct password". Expect Failure
      await tester.enterText(email, incorrectEmail);
      await tester.enterText(password, validPassword);
      tester.press(loginBtn);

      //3: Enter correct email and password. Expect success
      await tester.enterText(email, validEmail);
      await tester.enterText(password, validPassword);
      tester.press(loginBtn);

      //4: On Login expect to end up on consumer listings page. Look for
      //   some identifiable feature of page
      expect(find.text("Description"), findsWidgets);

      //5: Perform some sort of scrolling action

      //6: Click on a Job

      //7: Confirm job has indeed been opened through some identifying
      //   text like a title,Description etc

      //8: (To be continued as code is finalized)
    });

    testWidgets("SignUp and Use App", (WidgetTester tester) async {
      app.main(); //start the app from the main function
      await tester.pumpAndSettle();

      //Widgets of interest for sign up on login
      var signUp = find.widgetWithText(Text, "Don't have an account? ");
      expect(signUp, findsOneWidget);

      //0: Click the signup link
      await tester.tap(signUp);

      //1: If successful should be able to find textfield with "name"
      expect(find.text("name"), findsOneWidget);

      //Some variables for signing up
      var name = "John Doe";
      var email = "johnDoe@gmail.com";
      var cellphone = "012345678";
      var location = "Block A, Mars";
      var password = "Marshian123";
      var signUpBtn = find.widgetWithText(ElevatedButton, "Sign Up");
      //2: Fill in all details but make sure Password and Confirm Password
      //   do not match. Should get error
      await tester.enterText(find.widgetWithText(TextFormField, "name"), name);
      await tester.enterText(
          find.widgetWithText(TextFormField, "email"), email);
      await tester.enterText(
          find.widgetWithText(TextFormField, "cellphone"), cellphone);
      await tester.enterText(
          find.widgetWithText(TextFormField, "location"), location);
      await tester.enterText(
          find.widgetWithText(TextFormField, "password"), password);
      await tester.enterText(
          find.widgetWithText(TextFormField, "confirm password"), "asda");
      await tester.tap(signUpBtn);
      //have to find out how errors are displayed for signup

      //3: Fill in all fields except one and expect failure when clicking
      //   signup button
      await tester.enterText(find.widgetWithText(TextFormField, "name"), name);
      await tester.enterText(
          find.widgetWithText(TextFormField, "email"), email);
      await tester.enterText(
          find.widgetWithText(TextFormField, "cellphone"), cellphone);
      await tester.enterText(
          find.widgetWithText(TextFormField, "location"), location);
      await tester.enterText(
          find.widgetWithText(TextFormField, "password"), password);
      await tester.tap(signUpBtn);

      //have to find out how errors are displayed for incorrect signup
      //4: (To be continued as code is finalized)
    });*/
}
