import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:redux_comp/redux_comp.dart';

class SIgnUpPage extends StatefulWidget {
  final Store<AppState> store;
  const SIgnUpPage({Key? key, required this.store}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SIgnUpPage> {

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
