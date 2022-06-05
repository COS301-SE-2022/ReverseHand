import 'package:authentication/widgets/button.dart';
import 'package:authentication/widgets/textfield.dart';
import 'package:flutter_test/flutter_test.dart';
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
  });
}
