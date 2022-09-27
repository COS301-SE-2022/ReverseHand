import 'package:admin/admin.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/appbar.dart';
import 'package:redux_comp/redux_comp.dart';

void main() {
  var store = Store<AppState>(initialState: AppState.initial());

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets("Widget Test: View Review Reports Page",
      (WidgetTester tester) async {
    await tester.pumpWidget(
        createWidgetForTesting(child: ViewReviewReportsPage(store: store)));
    //verify certain static content is displayed correctly
    expect(find.widgetWithText(AppBarWidget, "Review Reports"), findsOneWidget);

    expect(find.text("There are no reported reviews."), findsOneWidget);
  });
}
