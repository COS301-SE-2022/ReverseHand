import 'package:flutter/material.dart';
import 'package:redux_comp/models/user_models/reset_password_model.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class ResetPasswordAction extends ReduxAction<AppState> {
  final String email;
  ResetPasswordAction(this.email);
  @override
  Future<AppState?> reduce() async {
    try {
      final result = await Amplify.Auth.resetPassword(username: email);
      debugPrint(result.isPasswordReset.toString());
      return state.copy(resetPasswordModel: ResetPasswordModel(email: email));
    } on AmplifyException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
