import 'package:async_redux/async_redux.dart';
import 'package:consumer/pages/advert_details_page.dart';
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

  testWidgets('Widget Test: Advert Details', (WidgetTester tester) async {
    await tester.pumpWidget(
        createWidgetForTesting(child: AdvertDetailsPage(store: store)));

    //verify certain static content is being displayed
    expect(find.widgetWithText(AppBarWidget, "JOB INFO"), findsOneWidget);
    expect(
        find.widgetWithText(LongButtonWidget, "View Bids (0)"), findsOneWidget);

    expect(find.widgetWithText(TransparentLongButtonWidget, "Delete"),
        findsOneWidget);
  });
}
