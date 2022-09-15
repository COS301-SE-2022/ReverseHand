import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/hint_widget.dart';
import 'package:redux_comp/actions/user/amplify_auth/set_otp__action.dart';
import 'package:redux_comp/app_state.dart';
import '../../pages/login_page.dart';
import '../auth_textfield_light.dart';
import '../link_widget.dart';
import 'new_password_popup_widget.dart';

//******************************** */
// Forgot password otp popup widget
//******************************** */

class FPOTPPopupWidget extends StatelessWidget {
  final otpController = TextEditingController();

  final Store<AppState> store;
  final void Function() function;

  FPOTPPopupWidget({
    Key? key,
    required this.store,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(this),
        builder: (BuildContext context, _ViewModel vm) => Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            color: const Color.fromARGB(255, 232, 232, 232),
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: 300,
                  child: Column(
                    children: [
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

                      //*****************Heading **********************
                      const Padding(padding: EdgeInsets.only(left:20, right: 20, bottom: 20)),
                      ButtonWidget(
                          text: "Verify",
                          function: () {
                            vm.dispatchStoreOtp(
                                otpController.value.text.trim());
                              vm.popPage();
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) =>
                                  NewPasswordPopupWidget(
                                store: store,
                                function: () {},
                              ),
                            );
                          })
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

// factory for view model
// ignore: unused_element
class _Factory extends VmFactory<AppState, FPOTPPopupWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchStoreOtp: (otp) => dispatch(SetOtpAction(otp)),
        popPage: () => dispatch(NavigateAction.pop())
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(String) dispatchStoreOtp;
  final VoidCallback popPage;

  _ViewModel({
    required this.dispatchStoreOtp,
    required this.popPage,
  });
}
