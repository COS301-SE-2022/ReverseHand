import '../../../app_state.dart';
import 'package:async_redux/async_redux.dart';

class SetOtpAction extends ReduxAction<AppState> {
  String otp;

  SetOtpAction(this.otp);
	@override
	Future<AppState?> reduce() async {
    return state.copy(
      resetPasswordModel: state.resetPasswordModel!.copy(
        otp: otp
      )
    );
  }
}
