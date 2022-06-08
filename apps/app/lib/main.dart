import 'package:async_redux/async_redux.dart';
import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/redux_comp.dart';

void main() async {
  // acts as main function
  runApp(
    LoginPage(
      store: Store<AppState>(
        initialState: AppState.initial(),
      ),
    ),
  );
}
