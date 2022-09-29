import 'package:authentication/methods/validation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Test", (WidgetTester tester) async {
    RegExp reg =
        RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');
    String kind = 'email';
    String invalidMsg = 'is invalid';

    final x = createValidator(kind, invalidMsg, reg);
    expect('A email must be entered', x(null));
    expect("Email is invalid", x("Test"));
  });
}
