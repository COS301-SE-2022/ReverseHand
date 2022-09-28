import 'package:consumer/widgets/delete_advert_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general/widgets/button.dart';

void main() {
  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets("Widget Test: ", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(
        child: DeletePopUpWidget(
      action: () {},
    )));
    //check for certain static content

    expect(
        find.text(
            "Are you sure you want to delete this job?\n\n This action cannot be undone."),
        findsOneWidget);

    expect(find.widgetWithText(ButtonWidget, "Delete"), findsOneWidget);
    expect(find.widgetWithText(ButtonWidget, "Cancel"), findsOneWidget);
  });
}
