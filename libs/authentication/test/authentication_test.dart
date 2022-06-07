import 'package:async_redux/async_redux.dart';
import 'package:authentication/pages/login.dart';
import 'package:authentication/widgets/button.dart';
import 'package:authentication/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/app_state.dart';

void main() {
  final store = Store<AppState>(initialState: AppState.mock());

  group("Authentication: ", () {
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

    testWidgets("Testing the Signup page", (WidgetTester tester) async {
      await tester.pumpWidget(LoginPage(store: store));

      //get the sign up widget at the bottom of the page
      final signUp = find.widgetWithText(GestureDetector, "Sign Up");
      expect(signUp, findsOneWidget);

      //press the sign up text and proceed to the signup page
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

      var description =
          find.text("Enter verification code sent to your email/phone");
      expect(description,
          findsOneWidget); //this should be confirmation popup is up

      //get the otp text field
      var otp = find.widgetWithText(TextFieldWidget, "otp");
      expect(otp, findsOneWidget);

      //enter something into the otp textfield
      await tester.enterText(otp, "12345");
      await tester.pumpAndSettle();

      //there should be a big verify button which is just checked for existence
      expect(find.text("Verify"), findsOneWidget);

      //lastly try and click that Sign In link at the bottom of the page and see
      //if it takes you to correct page

      var signIn = find.widgetWithText(GestureDetector, "Sign In");
      expect(signIn, findsOneWidget);

      //check for the other text surroundig Sign In if its correct
      expect(find.text("Already have an account? "), findsOneWidget);

      expect(find.text("or"), findsOneWidget);
    });
  });
}
