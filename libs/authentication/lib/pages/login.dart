import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:redux_comp/actions/view_bids_action.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:authentication/methods/populate_login.dart';
import 'package:amplify/amplifyconfiguration.dart';
import 'package:amplify/models/ModelProvider.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class LoginPage extends StatefulWidget {
  final Store<AppState> store;
  const LoginPage({Key? key, required this.store}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() async {
    await _initializeApp();
    super.initState();
    widget.store.dispatch(ViewBidsAction());
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        home: Login(store: widget.store),
        theme: CustomTheme.darkTheme,
      ),
    );
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

  Future<void> _initializeApp() async {
    // configure Amplify
    await _configureAmplify();
  }
}
