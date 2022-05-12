import 'package:flutter_test/flutter_test.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/login.dart';
import 'package:redux_comp/redux_comp.dart';

void main() {
  //Create a store to use for the various states
  final store = Store<AppState>(initialState: AppState.mock());

  //testing the login class
  testWidgets(
      "Testing the login class to see if it holds exactly Login page widget",
      (WidgetTester tester) async {
    await tester.pumpWidget(LoginPage(store: store));

    final page = find.byType(LoginPage);
    expect(page, findsOneWidget);
  });

  testWidgets("Testing the widgets in _LoginPageState",
      (WidgetTester tester) async {
    var x = LoginPage(store: store);
    // var y = x.createState();
    await tester.pumpWidget(x);

    //Expect to find one scaffhold widget
    var scaffhold = find.byType(Scaffold);
    expect(scaffhold, findsOneWidget);

    //expect to find login page string in the page
    var loginPage = find.text("Login Page");
    expect(loginPage, findsOneWidget);

    //expect to find one SingleChildScrollView
    var scroll = find.descendant(
        of: scaffhold, matching: find.byType(SingleChildScrollView));
    expect(scroll, findsOneWidget);

    //expect to find 2 TextFields
    var textfield =
        find.descendant(of: scroll, matching: find.byType(TextField));

    expect(textfield, findsNWidgets(2));

    //Find a textField with email in it
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);

    //find one widget with text Password
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);

    //push the login button
    await tester.tap(find.widgetWithText(TextButton, "Login"));

    //wait for the push of login button
    await tester.pumpAndSettle();

    //should see something with My Job Listing on the page if success
    expect(find.text("My Job Listings"), findsOneWidget);
  });
}
