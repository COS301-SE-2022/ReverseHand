import 'package:async_redux/async_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:tradesman/tradesman.dart';

void main() {
  testWidgets("Test Job listings", (WidgetTester tester) async {
    final store = Store<AppState>(initialState: AppState.mock());
    //spin up the widget
    await tester.pumpWidget(TradesmanJobListings(store: store));

    //can only test if the logout button is visible
    // expect(find.text("My jobs"), findsOneWidget);
  });
}
