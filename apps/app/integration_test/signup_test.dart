import 'package:authentication/widgets/button.dart';
import 'package:authentication/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

//Flutter test integration_test/signup_test.dart
void main() {
  //make sure service is initialized first to run on device
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("SignUp and use Appp", (WidgetTester tester) async {
    app.main(); //start the app from the main function
    await tester.pumpAndSettle();

    //NB: Anytime  you tap, scroll, press etc you must use
    // the pump and settle method of the WidgetTester

    //storing widget which is sign up link
    var signUp = find.widgetWithText(GestureDetector, "Sign Up");
    expect(signUp, findsOneWidget);
    //click the link and go to the sign up page
    await tester.tap(signUp);
    await tester.pumpAndSettle();

    //Landed on the signup page
    //Now getting the necessary widgets as variables

    var email = find.widgetWithText(TextFieldWidget, "email");
    expect(email, findsOneWidget);

    var password = find.widgetWithText(TextFieldWidget, "password");
    expect(password, findsOneWidget);

    var confirmPassword =
        find.widgetWithText(TextFieldWidget, "confirm password");
    expect(confirmPassword, findsOneWidget);

    var signUpBtn =
        find.widgetWithText(LongButtonWidget, "Sign Up"); //press action
    expect(signUpBtn, findsOneWidget);

    //Entering an email in the emeail field
    await tester.enterText(email,
        "johnny.Bravo@gmail.com"); //might have to change this to a valid email most probably
    await tester.pumpAndSettle();

    //entering a password
    await tester.enterText(password, "password123");
    await tester.pumpAndSettle();

    //entering confirm password
    await tester.enterText(confirmPassword, "password123");
    await tester.pumpAndSettle();
  });
}
