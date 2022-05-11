//import 'package:example/example.dart';
import 'package:async_redux/async_redux.dart';
import 'package:general/general.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/redux_comp.dart';

void main() {
  // setting up redux
  final store = Store<AppState>(initialState: AppState.initial());
  runApp(Login(
    store: store,
  ));
}
