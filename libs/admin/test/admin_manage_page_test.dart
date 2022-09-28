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

  testWidgets("Widget Test: Admin nav bar", (WidgetTester tester) async {
    await tester.pumpWidget(
        createWidgetForTesting(child: AdminManagePage(store: store)));

    //verifying certain descriptive text is present on the page.
    expect(find.widgetWithText(AppBarWidget, "Content Management"),
        findsOneWidget);

    expect(find.widgetWithText(AdminContainerWidget, "Advert Reports"),
        findsOneWidget);

    expect(find.widgetWithText(AdminContainerWidget, "User Reports"),
        findsOneWidget);

    expect(find.widgetWithText(AdminContainerWidget, "Review Reports"),
        findsOneWidget);
  });
}
