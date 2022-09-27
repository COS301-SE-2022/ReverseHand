import 'package:admin/pages/admin_profile_page.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/redux_comp.dart';

void main() {
  var store = Store<AppState>(initialState: AppState.initial());

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets("Widget Test: Admin Profile", (WidgetTester tester) async {
    await tester.pumpWidget(
        createWidgetForTesting(child: AdminProfilePage(store: store)));

    //verify certain static content exists on the page
    expect(find.text("Profile"), findsOneWidget);
    expect(find.text("null"), findsWidgets);

    expect(find.byIcon(Icons.email), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);

    expect(find.byIcon(Icons.arrow_forward_ios), findsNWidgets(2));
    expect(find.byIcon(Icons.location_on), findsOneWidget);

    expect(find.byIcon(Icons.logout), findsOneWidget);
  });
}
