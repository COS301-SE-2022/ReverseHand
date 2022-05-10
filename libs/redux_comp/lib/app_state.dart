import 'package:amplify/amplify.dart';
import 'package:amplify/amplifyconfiguration.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class AppState {
  // put all app state requiered here
  final String example; // remove later

  // amplify
  final AmplifyDataStore _dataStorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);

  // constructor must only take named parameters
  AppState({required this.example});

  // this methods sets the starting state for the store
  static AppState initial() {
    return AppState(example: "example");
  }

  // used for configuring amplify
  Future<void> _initializeApp() async {
    Future<void> _configureAmplify() async {
    try {

      // add Amplify plugins
      await Amplify.addPlugins([_dataStorePlugin]);

      // configure Amplify
      //
      // note that Amplify cannot be configured more than once!
      await Amplify.configure(amplifyconfig);
    } catch (e) {

      // error handling can be improved for sure!
      // but this will be sufficient for the purposes of this tutorial
      print('An error occurred while configuring Amplify: $e');
    }
  }
}

Future<void> _configureAmplify() async {
  // to be filled in a later step
}
