import 'package:async_redux/async_redux.dart';
import 'package:authentication/widgets/transparent_divider.dart';
import 'package:authentication/widgets/auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/blue_button_widget.dart';
import 'package:redux_comp/actions/user/amplify_auth/verify_user_action.dart';
import 'package:redux_comp/app_state.dart';

import '../pages/login_page.dart';
import 'link_widget.dart';


//******************************** */
// OTP popup widget
//******************************** */

class OTPPopupWidget extends StatelessWidget {
  final otpController = TextEditingController();

  final Store<AppState> store;

  OTPPopupWidget({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Center(
        child: Column(
          children: <Widget>[
            //*****************Heading **********************
            Container(
              margin: const EdgeInsets.only(top: 120, left: 25, right: 25),
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.topCenter,
              child: const Text(
                "Enter verification code sent to your email",
                style: TextStyle(fontSize: 21),
                textAlign: TextAlign.center,
              ),
            ),
            const TransparentDividerWidget(),
            //*****************************************************

            //*****************OTP text field**********************
            Container(
              margin: const EdgeInsets.only(left: 25, right: 25),
              padding: const EdgeInsets.all(8.0),
              child: AuthTextFieldWidget(
                label: 'otp',
                obscure: false,
                icon: Icons.domain_verification_outlined,
                controller: otpController,
              ),
            ),
            const TransparentDividerWidget(),
            //*****************************************************

            //*****************Heading **********************
            LinkWidget(
              text1: "Didn't receive OTP? ",
              text2: "Resend",
              navigate: () => LoginPage(store: store),
              colour: Colors.grey
            ),
            const TransparentDividerWidget(),
            //*****************************************************

            //***************Verify Button *********************** */
            StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) =>
                  BlueButtonWidget(
                text: "Verify OTP",
                function: () => vm
                    .dispatchVerifyUserAction(otpController.value.text.trim()),
                width: 150,
                height: 50,
                icon: Icons.domain_verification_outlined,
              ),
            ),
            //*****************************************************
          ],
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, OTPPopupWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchVerifyUserAction: (otp) => dispatch(VerifyUserAction(otp)),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(String) dispatchVerifyUserAction;

  _ViewModel({
    required this.dispatchVerifyUserAction,
  }); // implementing hashcode
}
