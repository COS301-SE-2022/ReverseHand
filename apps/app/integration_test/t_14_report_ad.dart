import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/appbar_popup_menu_widget.dart';
import 'package:general/widgets/textfield.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

void main() {
  //make sure service is initialized first to run on device
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Tradesman Report Ad", (WidgetTester tester) async {
    app.main(); //start the app from the main function
    await tester.pumpAndSettle();

    //storing constants used to login as tradesman
    const email = "yojeja5123@edxplus.com";
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

    ////////////////////////////////////////////////////////////////
    //Job Listings Page

    var jobOne = find.text("Integration Test");
    expect(jobOne, findsOneWidget);

    await tester.tap(jobOne);
    await tester.pumpAndSettle();

    //////////////////////////////////////////////////////////////
    //Job Info Page

    await tester.tap(find.byType(AppbarPopUpMenuWidget));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Report Advert"));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Harrassment"));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFieldWidget), "Harrasment");
    await tester.pumpAndSettle();

    await tester.dragUntilVisible(find.text("Submit Job Report"),
        find.byType(Scaffold), const Offset(0.0, 300));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 1), () {});

    await tester.tap(find.text("Submit Job Report"), warnIfMissed: false);
    await tester.pumpAndSettle();
  });
}
