import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

void main() {
  //make sure service is initialized first to run on device
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Login And Use App", (WidgetTester tester) async {
    app.main(); //start the app from the main function
    await tester.pumpAndSettle();
  });
}
