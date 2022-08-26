import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

void main() {
  //make sure service is initialized first to run on device
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  //Command: flutter test integration_test/tradesman_view_jobs.dart

  testWidgets("View Consumer Jobs as Tradesman", (WidgetTester tester) async {
    app.main(); //start the app from the main function
    await tester.pumpAndSettle();

    //storing constants used to login as consumer
    const email = "tradesman.cachemoney@gmail.com";
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

    //-----------------------------------------------------------------------
    //Job listings Page

    //get the work icon
    var briefCase = find.widgetWithIcon(IconButton, Icons.work);
    expect(briefCase, findsOneWidget);
    //press the work icon
    await tester.tap(briefCase);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 3), () {});

    //get the job widget
    var jobOne = find.widgetWithText(QuickViewJobCardWidget, "Umhlanga/Tester");
    expect(jobOne, findsOneWidget);

    //scrolling a bit
    await tester.dragUntilVisible(
        jobOne, find.byType(Scaffold), const Offset(0.0, 300));
    await tester.pumpAndSettle();

    //press the advert/job
    await tester.tap(jobOne);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 5), () {});
    await tester.tap(jobOne, warnIfMissed: false);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5), () {});

    //Get the back button Widget
    var backBtn = find.widgetWithText(ButtonWidget, "Back");
    expect(backBtn, findsOneWidget);

    //press the Back Button
    await tester.tap(backBtn);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 3), () {});

    await Future.delayed(const Duration(seconds: 3), () {});

    //To add: Some more adverts to click on
    var jobTwo =
        find.widgetWithText(QuickViewJobCardWidget, "Umhlanga/Tester2");
    expect(jobTwo, findsOneWidget);

    //press the advert/job
    await tester.tap(jobTwo);
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 5), () {});
    await tester.tap(jobTwo, warnIfMissed: false);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5), () {});

    //Get the back button Widget
    backBtn = find.widgetWithText(ButtonWidget, "Back");
    expect(backBtn, findsOneWidget);

    //press the Back Button
    await tester.tap(backBtn);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 3), () {});
  });
}
