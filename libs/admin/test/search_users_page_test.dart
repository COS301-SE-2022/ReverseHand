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

  testWidgets("Widget Test: Search Users Page", (WidgetTester tester) async {
    await tester.pumpWidget(
        createWidgetForTesting(child: SearchUsersPage(store: store)));

    //verify certain static content is being displayed
    expect(find.widgetWithText(AppBarWidget, "List Users"), findsOneWidget);
    expect(find.byIcon(Icons.clear), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);

    expect(find.widgetWithText(TabBar, "Client"), findsOneWidget);
    expect(find.widgetWithText(TabBar, "Contractor"), findsOneWidget);

    expect(find.text("No customer user's found"), findsOneWidget);
  });
}
