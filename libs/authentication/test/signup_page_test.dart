// import 'package:async_redux/async_redux.dart';
// import 'package:authentication/authentication.dart';
// import 'package:authentication/widgets/auth_button.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:general/widgets/hint_widget.dart';
// import 'package:redux_comp/redux_comp.dart';

// void main() {
//   var store = Store<AppState>(initialState: AppState.initial());

//   testWidgets("Unit Test: SignUp Page", (WidgetTester tester) async {
//     await tester.pumpWidget(SignUpPage(store: store));

//     //verify that the email text is visible
//     expect(find.widgetWithText(AuthTextFieldWidget, "email"), findsOneWidget);

//     //verify the password text is visible
//     expect(
//         find.widgetWithText(AuthTextFieldWidget, "password"), findsOneWidget);

//     //verify that confirm password exists
//     expect(find.widgetWithText(AuthTextFieldWidget, "confirm password"),
//         findsOneWidget);

//     //verify that the signup button exists
//     expect(find.widgetWithText(AuthButtonWidget, "Sign Up"), findsOneWidget);

//     //verify the or tet exists in the divider
//     expect(find.text("or"), findsOneWidget);

//     //verify the 'already have an account? ' text exists on page
//     expect(find.text("Already have an account? "), findsOneWidget);

//     //verify that the 'Sign In' text still exists
//     expect(find.text("Sign In"), findsOneWidget);

//     //attempt to enter some text in the email field
//     await tester.enterText(
//         find.widgetWithText(AuthTextFieldWidget, "email"), "example@gmail.com");
//     await tester.pumpAndSettle();

//     //attempt to enter some text in the password field
//     await tester.enterText(
//         find.widgetWithText(AuthTextFieldWidget, "password"), "password123");
//     await tester.pumpAndSettle();

//     //attemp to enter some text in the confirm password field
//     await tester.enterText(
//         find.widgetWithText(AuthTextFieldWidget, "confirm password"),
//         "password123");
//     await tester.pumpAndSettle();

//     //press the signup button
//     await tester.tap(find.text("Sign Up"));
//     await tester.pumpAndSettle();

//     //check that the pop up for otp showed up
//     expect(find.text("Verify"), findsOneWidget);
//     await tester.pumpAndSettle();

//     expect(find.text("OTP Verification"), findsOneWidget);

//     expect(find.widgetWithText(HintWidget, "Enter OTP sent to email"),
//         findsOneWidget);

//     //check the resend text
//     expect(find.text("Didn't receive OTP? "), findsOneWidget);
//     expect(find.text("Resend"), findsOneWidget);
//   });
// }
