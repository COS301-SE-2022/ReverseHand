import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:redux_comp/redux_comp.dart';
// import 'package:consumer/consumer.dart';
import 'package:general/populate_login.dart';

class LoginPage extends StatefulWidget {
  final Store<AppState> store;
  const LoginPage({Key? key, required this.store}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
