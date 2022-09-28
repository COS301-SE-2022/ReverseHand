import 'package:async_redux/async_redux.dart';
import 'package:consumer/pages/limited_consumer_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/appbar_popup_menu_widget.dart';
import 'package:general/widgets/hint_widget.dart';
import 'package:redux_comp/redux_comp.dart';

void main() {
  var store = Store<AppState>(initialState: AppState.initial());

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets("Widget Test: ", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(
        child: LimitedConsumerProfilePage(store: store)));

    //verify certain static components are being displayed
    expect(find.widgetWithText(AppBarWidget, "PROFILE"), findsOneWidget);

    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);

    expect(find.text("Total adverts closed: 0"), findsOneWidget);
    expect(find.text("Total adverts made: 0"), findsOneWidget);
  });
}
