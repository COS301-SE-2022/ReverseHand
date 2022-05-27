import 'package:async_redux/async_redux.dart';
import 'package:authentication/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/app_state.dart';

void main() {
  final store = Store<AppState>(initialState: AppState.mock());
  testWidgets("Testing LoginPage class", (WidgetTester tester) async {
    await tester.pumpWidget(LoginPage(store: store));

    final email = find.text("email");
    expect(email, findsOneWidget);

    final password = find.text("password");
    expect(password, findsOneWidget);

    final login = find.text("Login");
    expect(login, findsOneWidget);
    expect(find.widgetWithText(Text, "login"), findsNothing);
    expect(find.text("or"), findsOneWidget);

    final signUp = find.text("Sign Up");
    expect(signUp, findsOneWidget);
    expect(find.text("SignUp"), findsNothing);

    final message = find.text("Don't have an account? ");
    expect(message, findsOneWidget);
    expect(find.text("or login with:"), findsOneWidget);
    expect(find.text("Don't have an account?"), findsNothing);
  });
}
