import 'package:amplify/amplify.dart';
import 'package:amplify/amplifyconfiguration.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class AppState {
  // put all app state requiered here
  final String example; // remove later

  // amplify
  final AmplifyDataStore _dataStorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);
  final AmplifyAPI _apiPlugin = AmplifyAPI();

  // constructor must only take named parameters
  AppState({required this.example}) {
    _initializeApp();
  }

  // this methods sets the starting state for the store
  static AppState initial() {
    return AppState(example: "example");
  }

  // used for configuring amplify
  Future<void> _initializeApp() async {
    await _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      // add Amplify plugins
      await Amplify.addPlugins([_dataStorePlugin, _apiPlugin]);

      // configure Amplify
      //
      // note that Amplify cannot be configured more than once!
      if (!Amplify.isConfigured) await Amplify.configure(amplifyconfig);
    } catch (e) {
      // error handling can be improved for sure!
      // but this will be sufficient for the purposes of this tutorial
      print('An error occurred while configuring Amplify: $e');
    }
  }
}
