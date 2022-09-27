import 'package:admin/admin.dart';
import 'package:admin/widgets/box_widget.dart';
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

  testWidgets("Widget Test: System Metrics page", (WidgetTester tester) async {
    await tester.pumpWidget(
        createWidgetForTesting(child: SystemMetricsPage(store: store)));

    //verify certain static content is available
    expect(find.widgetWithText(AppBarWidget, "System Metrics"), findsOneWidget);
    expect(find.widgetWithText(BoxWidget, "Database"), findsOneWidget);
    expect(find.widgetWithText(BoxWidget, "API"), findsOneWidget);
    expect(find.widgetWithText(BoxWidget, "Resolvers"), findsOneWidget);
    expect(find.widgetWithText(BoxWidget, "Auth"), findsOneWidget);

    expect(find.widgetWithIcon(BoxWidget, Icons.storage), findsOneWidget);
    expect(find.widgetWithIcon(BoxWidget, Icons.network_ping), findsOneWidget);
    expect(find.widgetWithIcon(BoxWidget, Icons.code), findsOneWidget);
    expect(find.widgetWithIcon(BoxWidget, Icons.security), findsOneWidget);
  });
}
