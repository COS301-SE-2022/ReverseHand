import 'package:authentication/widgets/button.dart';
import 'package:authentication/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

void main() {
  //make sure service is initialized first to run on device
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Login And Use App", (WidgetTester tester) async {
    app.main(); //start the app from the main function
    await tester.pumpAndSettle();

    //landing page is the login page
    final email = "cachemoney.up@gmail.com";
    final password = "password123";

    //storing important fields from the login page in variables
    var email_field = find.widgetWithText(TextFieldWidget, "email");
    expect(email_field, findsOneWidget); //find one such field
    var password_field = find.widgetWithText(TextFieldWidget, "password");
    expect(password_field, findsOneWidget);
    var login_button = find.widgetWithText(LongButtonWidget, "login");
    expect(login_button, findsOneWidget);

    //Note: await tester.pumpAndSettle is required after any form of
    //clicking, tapping, entering text, scrolling etc

    //entering the email into the field
    await tester.enterText(email_field, email);
    await tester.pumpAndSettle();
    //enterig the password into the field
    await tester.enterText(password_field, password);
    await tester.pumpAndSettle();
    //press the login button
    await tester.press(login_button);
    await tester.pumpAndSettle();
  });
}
