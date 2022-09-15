import 'package:flutter/material.dart';

import '../../../app_state.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';

class ResendVerificationOtpAction extends ReduxAction<AppState> {
  String email;

  ResendVerificationOtpAction(this.email);

  @override
  Future<AppState?> reduce() async {
    try {
      final result = await Amplify.Auth.resendSignUpCode(
        username: email,
      );
      final destination = result.codeDeliveryDetails.destination;
      debugPrint(destination);
      return null;
    } on AmplifyException catch (e) {
      debugPrint(e.message);
      return null;
    }
  }
}
