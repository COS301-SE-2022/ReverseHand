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
    testWidgets("Login And Use App", (WidgetTester tester) async {
      app.main(); //start the app from the main function
      await tester.pumpAndSettle();

      //0: Just click login with nothing entered and that should fail

      //1:Enter correct email and then wrong password. Expect Failure

      //2: Enter wrong email and then "correct password". Expect Failure

      //3: Enter correct email and password. Expect success

      //4: On Login expect to end up on consumer listings page. Look for
      //   some identifiable feature of page

      //5: Perform some sort of scrolling action

      //6: Click on a Job

      //7: Confirm job has indeed been opened through some identifying
      //   text like a title,Description etc

      //8: (To be continued as code is finalized)
    });

    testWidgets("SignUp and Use App", (WidgetTester tester) async {
      app.main(); //start the app from the main function
      await tester.pumpAndSettle();

      //0: Click the signup link

      //1: If successful should be able to find textfield with "name"

      //2: Fill in all details but make sure Password and Confirm Password
      //   do not match. Should get error

      //3: Fill in all fields except one and expect failure when clicking
      //   signup button

      //4: (To be continued as code is finalized)
    });
  });
}
