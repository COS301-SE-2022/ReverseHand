import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/hint_widget.dart';
import 'package:redux_comp/actions/user/amplify_auth/complete_password_reset_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:authentication/methods/validation.dart';
import '../auth_textfield_light.dart';

//******************************** */
// Forgot password otp popup widget
//******************************** */

class NewPasswordPopupWidget extends StatelessWidget {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final Store<AppState> store;
  final void Function() function;

  NewPasswordPopupWidget({
    Key? key,
    required this.store,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      vm: () => _Factory(this),
      builder: (BuildContext context, _ViewModel vm) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          color: const Color.fromARGB(255, 232, 232, 232),
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 360,
                child: Column(
                  children: [
                    const Text("New password",
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    const Padding(padding: EdgeInsets.all(10)),
                    //*****************Password text field**********************
                    const HintWidget(
                        text: "Enter new password",
                        colour: Colors.black,
                        padding: 95),
                    Container(
                      margin: const EdgeInsets.only(left: 25, right: 25),
                      padding: const EdgeInsets.all(8.0),
                      child: AuthTextFieldLightWidget(
                        label: 'new password',
                         obscure: true,
                        icon: Icons.lock_open_outlined,
                        controller: newPasswordController,
                        validator: createValidator(
                          'password',
                          'must be at least 8 characters with upper and lowercase, atleast one number and special character',
                          RegExp(
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                          ),
                        ),
                      ),
                    ),
                    //*****************************************************

                    //*****************Confirm Password text field**********************
                    const HintWidget(
                        text: "Confirm password",
                        colour: Colors.black,
                        padding: 95),
                    Container(
                      margin: const EdgeInsets.only(left: 25, right: 25),
                      padding: const EdgeInsets.all(8.0),
                      child: AuthTextFieldLightWidget(
                        label: 'confirm password',
                         obscure: true,
                        icon: Icons.lock_outline_rounded,
                        controller: confirmPasswordController,
                        validator: createValidator(
                          'password',
                          'must be at least 8 characters with upper and lowercase, atleast one number and special character',
                          RegExp(
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                          ),
                        ),
                      ),
                    ),
                    //*****************************************************

                    //*****************BUTTON**********************
                    const Padding(padding: EdgeInsets.all(20)),
                    ButtonWidget(
                        text: "Send",
                        function: () {
                          vm.dispatchConfirmPasswordReset(
                            newPasswordController.value.text.trim(),
                          );
                          vm.popPage();
                        })
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

// factory for view model
// ignore: unused_element
class _Factory extends VmFactory<AppState, NewPasswordPopupWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      dispatchConfirmPasswordReset: (newPass) =>
          dispatch(CompletePasswordResetAction(newPass)),
      popPage: () => dispatch(NavigateAction.pop()));
}

// view model
class _ViewModel extends Vm {
  final void Function(String) dispatchConfirmPasswordReset;
  final VoidCallback popPage;

  _ViewModel({
    required this.dispatchConfirmPasswordReset,
    required this.popPage,
  });
}
