import 'package:admin/admin.dart';
import 'package:admin/widgets/text_row_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:redux_comp/redux_comp.dart';

void main() {
  var store = Store<AppState>(initialState: AppState.initial());

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets("Widget Test: User Metrics Page", (WidgetTester tester) async {
    await tester.pumpWidget(
        createWidgetForTesting(child: UserMetricsPage(store: store)));

    //verify certain static content is appearing
    expect(find.widgetWithText(AppBarWidget, "User Metrics"), findsOneWidget);
    expect(
        find.widgetWithText(TextRowWidget, "Active Sessions"), findsOneWidget);

    expect(find.widgetWithText(ButtonWidget, "View Custom Metrics"),
        findsOneWidget);

    expect(find.widgetWithText(ButtonWidget, "View Chat Sentiment"),
        findsOneWidget);

    expect(find.widgetWithText(ButtonWidget, "Search Users"), findsOneWidget);
  });
}
