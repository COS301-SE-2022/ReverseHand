import 'package:flutter_test/flutter_test.dart';
import 'package:redux_comp/app_state.dart';

void main() {
  test("Checks to make sure store was properlly intialized", () {
    AppState store = AppState.mock();
    expect(store,
        const AppState(id: "1234567890", username: "TestName", adverts: [], signUpComplete: false));
  });
}
