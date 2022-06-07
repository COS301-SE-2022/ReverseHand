import 'package:async_redux/async_redux.dart';
import 'package:authentication/pages/login.dart';
import 'package:authentication/widgets/button.dart';
import 'package:authentication/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/app_state.dart';

void main() {
  final store = Store<AppState>(initialState: AppState.mock());

  group("Login Widget Test", () {
    testWidgets("Testing LoginPage page", (WidgetTester tester) async {
      await tester.pumpWidget(LoginPage(store: store));

      //store important widgets for testing in variables
      final email = find.widgetWithText(TextFieldWidget, "email");
      expect(email, findsOneWidget);
      final password = find.widgetWithText(TextFieldWidget, "password");
      expect(password, findsOneWidget);
      final login = find.widgetWithText(LongButtonWidget, "login");
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

      //simulating pressing the signup app button
      await tester.tap(signUp);
      await tester.pumpAndSettle();
      expect(find.text("name"),
          findsOneWidget); //this indicates successfully landed on the signup page
    });
  });
}
