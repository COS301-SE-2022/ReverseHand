//import 'package:example/example.dart';
import 'package:async_redux/async_redux.dart';
import 'package:general/general.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/redux_comp.dart';

void main() {
   runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final store = Store<AppState>(initialState: AppState.initial());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.darkTheme,
      home: LoginPage(store: store),
    );
  }
}
