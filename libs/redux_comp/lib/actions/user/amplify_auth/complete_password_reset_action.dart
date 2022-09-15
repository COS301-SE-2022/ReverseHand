import 'package:flutter/material.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class CompletePasswordResetAction extends ReduxAction<AppState> {
  String password;

  CompletePasswordResetAction(this.password);

	@override
	Future<AppState?> reduce() async {
    try {
    final result = await Amplify.Auth.confirmResetPassword(
        username: state.resetPasswordModel!.email,
        newPassword: password,
        confirmationCode: state.resetPasswordModel!.otp!
    );
    debugPrint(result.toString());
    return null;
  } on AmplifyException catch (e) {
    debugPrint(e.message);
    return null;
  }
  }
}
