//import 'package:example/example.dart';
import 'package:async_redux/async_redux.dart';
import 'package:authentication/authentication.dart';
import 'package:general/general.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/redux_comp.dart';

void main() {
   runApp(MyApp(store: Store<AppState>(initialState: AppState.initial())));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.darkTheme,
      home: LoginPage(store: store),
    );
  }
}
