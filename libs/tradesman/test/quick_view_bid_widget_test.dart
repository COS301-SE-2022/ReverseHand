import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:tradesman/widgets/quick_view_bid_widget.dart';

void main() {
  var store = Store<AppState>(initialState: AppState.initial());

  const bid = BidModel(
    id: "id",
    userId: "userId",
    price: 100,
    dateCreated: 12345,
    shortlisted: false,
    name: "Alex",
  );

  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets("Widget Test: ", (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetForTesting(
        child: TQuickViewBidWidget(store: store, bid: bid)));

    //verify certain static content is being displayed correctly
    expect(find.text("Alex"), findsOneWidget);
    expect(find.text("R1"), findsOneWidget);
  });
}
