import 'package:async_redux/async_redux.dart';
import 'package:consumer/pages/bid_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:redux_comp/redux_comp.dart';

void main() {
  var store = Store<AppState>(initialState: AppState.initial());

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Widget Test: Bid details Page', (WidgetTester tester) async {
    await tester.pumpWidget(
        createWidgetForTesting(child: BidDetailsPage(store: store)));

    //verify certain static content exists on the page
    expect(find.widgetWithText(AppBarWidget, "BID DETAILS"), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.bookmark_outline),
        findsOneWidget);

    expect(find.text("Quoted price"), findsOneWidget);

    expect(find.text("No quote has been\n uploaded yet."), findsOneWidget);

    expect(find.widgetWithText(LongButtonWidget, "Accept Bid"), findsOneWidget);

    expect(
        find.widgetWithText(
            TransparentLongButtonWidget, "View Contractor Profile"),
        findsOneWidget);
  });
}
