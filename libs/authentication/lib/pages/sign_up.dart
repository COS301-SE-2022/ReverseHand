import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:redux_comp/redux_comp.dart';

class SignUpPage extends StatefulWidget {
  final Store<AppState> store;
  const SignUpPage({Key? key, required this.store}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        //home: SignUp(store: widget.store),
        theme: CustomTheme.darkTheme,
      ),
    );
  }
}
