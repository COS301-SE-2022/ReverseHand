import 'package:async_redux/async_redux.dart';
import 'package:authentication/authentication.dart';
import 'package:authentication/widgets/button.dart';
import 'package:authentication/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/app_state.dart';

void main() {
  final store = Store<AppState>(initialState: AppState.mock());
  testWidgets("Testing LoginPage page", (WidgetTester tester) async {
    await tester.pumpWidget(LoginPage(store: store));

    //store important widgets for testing in variables
    final email = find.widgetWithText(TextFieldWidget, "email");
    expect(email, findsOneWidget);
    final password = find.widgetWithText(TextFieldWidget, "password");
    expect(password, findsOneWidget);
    final login = find.widgetWithText(LongButtonWidget, "Login");
    expect(login, findsOneWidget);

    expect(find.text("or"), findsOneWidget);
    final signUp = find.widgetWithText(GestureDetector, "Sign Up");
    expect(signUp, findsOneWidget);
    expect(find.text("SignUp"), findsNothing);

    final message = find.text("Don't have an account? ");
    expect(message, findsOneWidget);
    expect(find.text("or login with:"), findsOneWidget);
    expect(find.text("Don't have an account?"), findsNothing);

    //simulating entering text into email and password field
    await tester.enterText(email, "cachemoney@gmailcom");
    await tester.pumpAndSettle();

    await tester.enterText(password, "123456");
    await tester.pumpAndSettle();

    //NB: Cannot press the login button as amplify needs to be running.
    //Widget tests are not suppossed to have any running services. That's
    //for integration testing
    await tester.dragUntilVisible(
        signUp, find.byType(Scaffold), const Offset(0.0, 300));
    await tester.pumpAndSettle();
  });

  testWidgets("Testing the Signup page", (WidgetTester tester) async {
    await tester.pumpWidget(SignUpPage(store: store));

    final signUp = find.widgetWithText(GestureDetector, "Sign Up");
    expect(signUp, findsOneWidget);

    await tester.dragUntilVisible(
        signUp, find.byType(Scaffold), const Offset(0.0, 300));
    await tester.pumpAndSettle();

    await tester.tap(signUp);
    await tester.pumpAndSettle();

    //check whether we are on signup page by looking for "Sign Up"
    //text right on top of the page
    expect(find.text("Sign Up"), findsNWidgets(2));

    //store important widgets to be used
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
    var cPassword = find.widgetWithText(TextFieldWidget, "confirm password");
    expect(cPassword, findsOneWidget);
    var sUp = find.widgetWithText(LongButtonWidget, "Sign Up");
    expect(sUp, findsOneWidget);

    //Now entering text into the various fields
    await tester.enterText(name, "Alex");
    await tester.pumpAndSettle();

    await tester.enterText(email, "alex@gmail.com");
    await tester.pumpAndSettle();

    await tester.enterText(cellphone, "012345678");
    await tester.pumpAndSettle();

    await tester.enterText(location, "Hillcrest");
    await tester.pumpAndSettle();

    await tester.enterText(password, "password");
    await tester.pumpAndSettle();

    await tester.enterText(cPassword, "password");
    await tester.pumpAndSettle();

    //tap the sigup button and a pop with verify should show up
    await tester.tap(sUp);
    await tester.pumpAndSettle();
  });
}
