import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/hint_widget.dart';
import 'package:redux_comp/actions/user/amplify_auth/reset_password_action.dart';
import 'package:redux_comp/app_state.dart';
import '../../methods/validation.dart';
import '../auth_textfield_light.dart';
import 'otp_popup_widget.dart';

//******************************** */
// Forgot password email popup widget
//******************************** */

class FPEmailPopupWidget extends StatelessWidget {
  final emailController = TextEditingController();

  final Store<AppState> store;

  FPEmailPopupWidget({
    Key? key,
    required this.store,
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
                    const Text("Email Verification",
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    const Padding(padding: EdgeInsets.all(10)),
                    //*****************Email text field**********************
                    const HintWidget(
                        text: "Enter email to receive OTP",
                        colour: Colors.black,
                        padding: 75),
                    Container(
                      margin: const EdgeInsets.only(left: 25, right: 25),
                      padding: const EdgeInsets.all(8.0),
                      child: AuthTextFieldLightWidget(
                        label: 'email',
                        obscure: false,
                        icon: Icons.email_outlined,
                        controller: emailController,
                        validator: createValidator(
                            'email',
                            'is invalid',
                            RegExp(
                                r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')),
                      ),
                    ),
                    //*****************************************************

                    //*****************Heading **********************
                    const Padding(padding: EdgeInsets.all(20)),
                    ButtonWidget(
                      text: "Send",
                      function: () {
                        vm.dispatchResetPassword(
                            emailController.value.text.trim());
                        vm.popPage();
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) => FPOTPPopupWidget(
                            store: store,
                            function: () => {},
                          ),
                        );
                        
                        
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// factory for view model
// ignore: unused_element
class _Factory extends VmFactory<AppState, FPEmailPopupWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchResetPassword: (email) => dispatch(ResetPasswordAction(email)),
        popPage: () =>dispatch(NavigateAction.pop())
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(String) dispatchResetPassword;
  final VoidCallback popPage;

  _ViewModel({
    required this.dispatchResetPassword,
    required this.popPage,
  });
}
