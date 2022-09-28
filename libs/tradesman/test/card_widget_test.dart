import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:tradesman/widgets/card_widget.dart';

void main() {
  var store = Store<AppState>(initialState: AppState.initial());

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets("Widget Test: ", (WidgetTester tester) async {
    await tester.pumpWidget(
        createWidgetForTesting(child: CardWidget(store: store, title: "Test")));

    //verify certain static content is being displayed
    expect(find.widgetWithText(ButtonBar, "Test"), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.cancel), findsOneWidget);

    await tester.tap(find.widgetWithIcon(IconButton, Icons.cancel));
    await tester.pumpAndSettle();
  });
}
