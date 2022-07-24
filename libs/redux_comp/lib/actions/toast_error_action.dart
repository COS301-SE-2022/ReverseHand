import 'package:flutter/material.dart';
import 'package:general/methods/toast_error.dart';
import 'package:redux_comp/models/error_type_model.dart';
import '../app_state.dart';
import 'package:async_redux/async_redux.dart';

class ToastErrorAction extends ReduxAction<AppState> {
  final BuildContext context;
  final String msg;

  ToastErrorAction(this.context, this.msg);

  @override
  AppState? reduce() {
    displayToastError(context, msg);

    return state.copy(error: ErrorType.none);
  }
}
