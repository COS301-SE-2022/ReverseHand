import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:redux_comp/actions/view_bids_action.dart';
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() async {
    await widget.store.dispatch(InitAmplifyAction());
    super.initState();
    widget.store.dispatch(ViewBidsAction("a#001"));
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
}
