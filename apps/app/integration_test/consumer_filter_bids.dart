import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

//flutter test integration_test/consumer_filter_bids.dart

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Filter Bids", (WidgetTester tester) async {
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

    //Get the View Bids Button
    var viewBids = find.widgetWithText(ButtonWidget, "View Bids");
    expect(viewBids, findsOneWidget);

    //click the view bids button
    await tester.tap(viewBids);
    await tester.pumpAndSettle();

    //--------------------------------------------------------------------
    //View bids page

    //get the Filter widget
    var filter = find.widgetWithText(ButtonWidget, "Filter");
    expect(filter, findsOneWidget);

    //tap the filter button
    await tester.tap(filter);
    await tester.pumpAndSettle();

    //-------------------------------------------------------------------
    //popup when you press the filter button

    //Get the min and max fields
    var min = find.widgetWithText(TextFormField, "min");
    expect(min, findsOneWidget);

    var max = find.widgetWithText(TextFormField, "max");
    expect(max, findsOneWidget);

    //Enter min value
    await tester.enterText(min, "600");
    await tester.pumpAndSettle();

    //Enter max value
    await tester.enterText(max, "2100");
    await tester.pumpAndSettle();

    //find the Apply button
    var apply = find.widgetWithText(ButtonWidget, "Apply");
    expect(apply, findsOneWidget);

    //Scroll until the Apply button is visible
    await tester.dragUntilVisible(apply, find.byType(Scaffold),
        const Offset(0.0, 300)); //might need to adjust that 300 value

    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2), () {});

    //get the back button
    var backBtn = find.widgetWithText(ButtonWidget, "Back");
    expect(backBtn, findsOneWidget);

    //press the back button
    await tester.tap(backBtn);
    await tester.pumpAndSettle();
  });
}
