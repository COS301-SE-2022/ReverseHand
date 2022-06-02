import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

//Example of command to run integration test
//flutter drive \
//  --driver=test_driver/integration_test.dart \
//  --target=integration_test/counter_test.dart \
//  -d web-server

void main() {
  //make sure service is initialized first to run on device
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("End-To-End-Test", () {
    testWidgets("Use 90% of APP", (WidgetTester tester) async {
      app.main(); //start the app from the main function
    });
  });
}
