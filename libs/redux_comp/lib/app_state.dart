import 'package:amplify/amplify.dart';
<<<<<<< HEAD
//import 'package:amplify/amplifyconfiguration.dart'; // uncomment this after pull
=======
// import 'package:amplify/amplifyconfiguration.dart'; // uncomment this after pull
>>>>>>> 963b5c52217d46bbd5852b075efb2af73ce73f10
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/widgets.dart';

class AppState {
  // put all app state requiered here
  final String name; // users name

  // amplify
  // final AmplifyDataStore _dataStorePlugin =
  //     AmplifyDataStore(modelProvider: ModelProvider.instance);
  // final AmplifyAPI _apiPlugin =
  //     AmplifyAPI(modelProvider: ModelProvider.instance);

  // constructor must only take named parameters
  AppState({required this.name});

  // this methods sets the starting state for the store
  factory AppState.initial() {
    if (!Amplify.isConfigured) {
      WidgetsFlutterBinding.ensureInitialized();
      _initializeApp();
    }
    return AppState(name: "");
  }

  factory AppState.mock() {
    return AppState(name: "TestName");
  }

  // easy way to replace store wihtout specifying all paramters
  AppState replace({
    String? name,
  }) {
    return AppState(
      name: name ?? this.name,
    );
  }

  // ===========================================================================
  // used for configuring amplify
  static Future<void> _initializeApp() async {
    await _configureAmplify();
  }

  static Future<void> _configureAmplify() async {
    try {
      // add Amplify plugins
      await Amplify.addPlugins([
        AmplifyDataStore(modelProvider: ModelProvider.instance),
        AmplifyAPI(modelProvider: ModelProvider.instance)
      ]);

      // configure Amplify
      //
      // note that Amplify cannot be configured more than once!
<<<<<<< HEAD
//      await Amplify.configure(
//          amplifyconfig); // uncomment this line and add your amplify config package
=======
      // await Amplify.configure(
      //     amplifyconfig); // uncomment this line and add your amplify config package
>>>>>>> 963b5c52217d46bbd5852b075efb2af73ce73f10
    } catch (e) {
      // error handling can be improved for sure!
      // but this will be sufficient for the purposes of this tutorial
      // print('An error occurred while configuring Amplify: $e');
    }
  }
}
