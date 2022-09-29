import 'package:async_redux/async_redux.dart';
import 'package:consumer/pages/consumer_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/hint_widget.dart';
import 'package:redux_comp/redux_comp.dart';

void main() {
  var store = Store<AppState>(initialState: AppState.initial());

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Test', (WidgetTester tester) async {
    await tester.pumpWidget(
        createWidgetForTesting(child: ConsumerProfilePage(store: store)));

    //verify certain static content exists on the page
    expect(find.widgetWithText(AppBarWidget, "PROFILE"), findsOneWidget);

    expect(find.widgetWithText(HintWidget, "Press and hold to see past jobs"),
        findsOneWidget);

    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);

    expect(find.text("Total adverts closed: 0"), findsOneWidget);

    expect(find.byIcon(Icons.front_hand_outlined), findsOneWidget);

    expect(find.text("Total adverts made: 0"), findsOneWidget);

    expect(find.byIcon(Icons.email), findsOneWidget);
    expect(find.byIcon(Icons.person), findsNWidgets(2));

    expect(find.text("null"), findsNWidgets(3));
    expect(find.widgetWithIcon(IconButton, Icons.arrow_forward_ios),
        findsNWidgets(3));

    expect(find.byIcon(Icons.phone), findsOneWidget);
    expect(find.byIcon(Icons.location_on), findsOneWidget);

    expect(find.byIcon(Icons.logout), findsOneWidget);

    //verify the icons for the nav bar are present
    expect(find.byIcon(Icons.work), findsOneWidget);
    expect(find.byIcon(Icons.forum), findsOneWidget);
    expect(find.byIcon(Icons.notifications), findsOneWidget);
    expect(find.byIcon(Icons.person), findsNWidgets(2));
  });
}
