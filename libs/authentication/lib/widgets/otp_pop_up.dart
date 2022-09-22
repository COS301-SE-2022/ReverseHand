import 'package:async_redux/async_redux.dart';
import 'package:authentication/widgets/transparent_divider.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/hint_widget.dart';
import 'package:redux_comp/actions/user/amplify_auth/verify_user_action.dart';
import 'package:redux_comp/app_state.dart';
import '../pages/login_page.dart';
import 'auth_textfield_light.dart';
import 'link_widget.dart';

//******************************** */
// OTP popup widget
//******************************** */

class OTPPopupWidget extends StatefulWidget {
  final Store<AppState> store;

  const OTPPopupWidget({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  State<OTPPopupWidget> createState() => _OTPPopupWidgetState();
}

class _OTPPopupWidgetState extends State<OTPPopupWidget> {
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          color: const Color.fromARGB(255, 232, 232, 232),
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 300,
                child: Column(
                  children: [
                    //*****************Heading **********************
                    const Text("OTP Verification",
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    const Padding(padding: EdgeInsets.all(10)),

                    //*****************OTP text field**********************
                    const HintWidget(
                        text: "Enter OTP sent to email",
                        colour: Colors.black,
                        padding: 85),
                    Container(
                      margin: const EdgeInsets.only(left: 25, right: 25),
                      padding: const EdgeInsets.all(8.0),
                      child: AuthTextFieldLightWidget(
                        label: 'otp',
                        obscure: false,
                        icon: Icons.domain_verification_outlined,
                        controller: otpController,
                      ),
                    ),
                    //*****************************************************

                    //*****************Resend OTP **********************
                    LinkWidget(
                        text1: "Didn't receive OTP? ",
                        text2: "Resend",
                        navigate: () => LoginPage(store: widget.store),
                        colour: Colors.black),
                    const TransparentDividerWidget(),
                    //*****************************************************

                    //*****************Button **********************
                    const Padding(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20)),
                    StoreConnector<AppState, _ViewModel>(
                        vm: () => _Factory(this),
                        builder: (BuildContext context, _ViewModel vm) =>
                            ButtonWidget(
                              text: "Verify",
                              function: () => vm.dispatchVerifyUserAction(
                                  otpController.value.text.trim()),
                            )),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, _OTPPopupWidgetState> {
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
  });
}
