import 'package:chat/widgets/action_button_widget.dart';
import 'package:chat/widgets/quick_view_chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

void main() {
  //make sure service is initialized first to run on device
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Consumer Send Message", (WidgetTester tester) async {
    app.main(); //start the app from the main function
    await tester.pumpAndSettle();

    //storing constants used to login as consumer
    const email = "fiwij93949@orlydns.com";
    const passowrd = "@Aa12345";

    //get the widgets to enter text and login button
    var email_ = find.widgetWithText(TextFormField, "email");
    expect(email_, findsOneWidget);
    var password_ = find.widgetWithText(TextFormField, "password");
    expect(password_, findsOneWidget);
    var login = find.widgetWithText(ElevatedButton, "Login");
    expect(login, findsOneWidget);

    //now entering the values in the fields
    await tester.enterText(email_, email);
    await tester.pumpAndSettle();

    await tester.enterText(password_, passowrd);
    await tester.pumpAndSettle();

    //scrolling a bit
    await tester.dragUntilVisible(
        login, find.byType(Scaffold), const Offset(0.0, 300));
    await tester.pumpAndSettle();

    //now clicking the login button
    await tester.tap(login);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 3), () {});

    //Go to chat
    await tester.tap(find.widgetWithIcon(IconButton, Icons.forum));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 3), () {});

    await tester.tap(find.widgetWithText(QuickViewChatWidget, "Peter"));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 3), () {});
    await tester.tapAt(const Offset(10, 10));
    // await tester.tap(find.widgetWithText(QuickViewChatWidget, "Peter"));
    await tester.pumpAndSettle();

    await tester.tapAt(const Offset(10, 10));
    await Future.delayed(const Duration(seconds: 3), () {});
    await tester.tapAt(const Offset(10, 10));

    await tester.enterText(
        find.bySemanticsLabel("Type message"), "Hey Tradesman");
    await tester.pumpAndSettle();

    await tester
        .tap(find.widgetWithIcon(ActionButtonWidget, Icons.send_rounded));
    await tester.pumpAndSettle();
  });
}
