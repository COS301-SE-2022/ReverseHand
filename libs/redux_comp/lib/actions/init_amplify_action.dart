import 'package:amplify/amplifyconfiguration.dart';
import 'package:amplify/models/ModelProvider.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/foundation.dart';

import '../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class InitAmplifyAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    await _configureAmplify();

    return state;
  }
}

// ===========================================================================
// used for configuring amplify
Future<void> _configureAmplify() async {
  try {
    final AmplifyAPI api = AmplifyAPI(modelProvider: ModelProvider.instance);
    final AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    final AmplifyDataStore ds =
        AmplifyDataStore(modelProvider: ModelProvider.instance);

    // add Amplify plugins
    await Amplify.addPlugins([
      ds,
      api,
      authPlugin,
    ]);

    // configure Amplify
    // note that Amplify cannot be configured more than once!
    await Amplify.configure(
        amplifyconfig); // uncomment this line and add your amplify config package

    if (kDebugMode) {
      print('Amplify Successfully Configured 🎉');
    }
  } catch (e) {
    // error handling can be improved for sure!
    // but this will be sufficient for the purposes of this tutorial
    if (kDebugMode) {
      print('An error occurred while configuring Amplify: $e');
    }
  }
}
