import 'package:authentication/widgets/button.dart';
import 'package:authentication/widgets/link.dart';
import 'package:authentication/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

//This Integration test goes the Sign Up route to using the app
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
    var name = find.widgetWithText(TextFieldWidget, "name");
    expect(name, findsOneWidget);

    var email = find.widgetWithText(TextFieldWidget, "email");
    expect(email, findsOneWidget);

    var cellphone = find.widgetWithText(TextFieldWidget, "cellphone");
    expect(cellphone, findsOneWidget);

    var location = find.widgetWithText(TextFieldWidget, "location");
    expect(location, findsOneWidget);

    var password = find.widgetWithText(TextFieldWidget, "password");
    expect(password, findsOneWidget);

    var confirmPassword =
        find.widgetWithText(TextFieldWidget, "confirm password");
    expect(confirmPassword, findsOneWidget);

    var signUpBtn =
        find.widgetWithText(LongButtonWidget, "Sign Up"); //press action
    expect(signUpBtn, findsOneWidget);

    //Entering a name in the name field
    await tester.enterText(name, "Johnny Bravo");
    await tester.pumpAndSettle();

    //Entering an email in the emeail field
    await tester.enterText(email,
        "johnnyBravo@gmail.com"); //might have to change this to a valid email most probably
    await tester.pumpAndSettle();

    //entering a location
    await tester.enterText(location, "Block C, Hatfield");
    await tester.pumpAndSettle();

    //entering cellphone number
    await tester.enterText(cellphone, "0777888993");
    await tester.pumpAndSettle();

    //entering a password
    await tester.enterText(password, "password123");
    await tester.pumpAndSettle();

    //entering confirm password
    await tester.enterText(confirmPassword, "password123");
    await tester.pumpAndSettle();

    //press the signup button
    await tester.press(signUpBtn);
    await tester.pumpAndSettle();
  });
}
