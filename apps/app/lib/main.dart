import 'package:general/general.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_comp/redux_comp.dart';

void main() {
  // setting up redux
  final store = Store<AppState>(appReducer, initialState: AppState.initial());
  runApp(Login(
    store: store,
  ));
}
