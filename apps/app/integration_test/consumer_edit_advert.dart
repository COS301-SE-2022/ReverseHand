import 'package:authentication/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

//flutter test integration_test/consumer_edit_advert.dart

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Edit Advert", (WidgetTester tester) async {
    app.main(); //start the app from the main function
    await tester.pumpAndSettle();

    //storing constants used to login as consumer
    const email = "consumer.cachemoney@gmail.com";
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
    //------------------------------------------------------------//
    //Now on page showing Adverts
    //Get the "Integration Test Job"
    var testJobOne =
        find.widgetWithText(QuickViewJobCardWidget, "Integration Test Job v2");
    expect(testJobOne, findsOneWidget);

    //scrolling a bit
    await tester.dragUntilVisible(
        testJobOne, find.byType(Scaffold), const Offset(0.0, 300));
    await tester.pumpAndSettle();

    //click on the advert
    await tester.tap(testJobOne);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5), () {});

    await tester.tap(testJobOne, warnIfMissed: false);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 5), () {});

    //get the edit icon on the page
    var editIcon = find.widgetWithIcon(IconButton, Icons.edit);
    expect(editIcon, findsOneWidget);

    //press the edit Icon button
    await tester.tap(editIcon);
    await tester.pumpAndSettle();

    //------------------------------------------------------------------
    //Edit job page

    //Get the title and description widgets
    // var txt = "Integration Test Job v2"; //fix this afterwards
    var txt = "Title";
    // var title = find.widgetWithText(TextFieldWidget, txt);
    var title = find.bySemanticsLabel(txt);
    expect(title, findsOneWidget);

    // var desc = "This is a second job for testing purposes.";
    var desc = "Description";
    // var descr = find.widgetWithText(TextFieldWidget, desc);
    var descr = find.bySemanticsLabel(desc);

    expect(descr, findsOneWidget);

    //Enter new text into the fields

    await tester.enterText(title, "Integration Test Job v2");
    await tester.pumpAndSettle();

    await tester.enterText(descr, "This is a second job for testing purposes.");
    await tester.pumpAndSettle();

    //Get the Save Changes button
    var save = find.widgetWithText(ButtonWidget, "Save Changes");
    expect(save, findsOneWidget);

    //press the Save Changes
    await tester.tap(save);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 5), () {});
  });
}
