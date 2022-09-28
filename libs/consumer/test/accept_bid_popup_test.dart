import 'package:async_redux/async_redux.dart';
import 'package:consumer/widgets/accept_bid_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/button.dart';
import 'package:redux_comp/redux_comp.dart';

void main() {
  var store = Store<AppState>(initialState: AppState.initial());

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets("Widget Test: ", (WidgetTester tester) async {
    await tester.pumpWidget(
        createWidgetForTesting(child: AcceptPopUpWidget(store: store)));

    //verify certain static content is being displayed
    expect(
        find.text(
            "Are you sure you want to accept this bid?\n\n All other bids will be discarded and payment will have to be made."),
        findsOneWidget);
    expect(find.widgetWithText(ButtonWidget, 'Accept'), findsOneWidget);
    expect(find.widgetWithText(ButtonWidget, 'Cancel'), findsOneWidget);
  });
}
