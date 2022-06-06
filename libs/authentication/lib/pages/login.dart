import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/init_amplify_action.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:authentication/methods/populate_login.dart';

class LoginPage extends StatefulWidget {
  final Store<AppState> store;
  const LoginPage({Key? key, required this.store}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  @override
 void initState() {
   widget.store.dispatch(InitAmplifyAction());
   super.initState();
 }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        home: Login(store: widget.store),
      ),
    );
  }
}
