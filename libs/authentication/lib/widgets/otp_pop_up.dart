import 'package:async_redux/async_redux.dart';
import 'package:authentication/widgets/divider.dart';
import 'package:authentication/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';
import 'package:redux_comp/actions/verify_user_action.dart';
import 'package:redux_comp/app_state.dart';

import '../methods/populate_login.dart';

class PopupWidget extends StatelessWidget {
  final otpController = TextEditingController();

  final Store<AppState> store;

  PopupWidget({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Center(
        child: Container(
          height: 350,
          decoration: const BoxDecoration(
              color: Colors.black87,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(30.0),
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.topCenter,
                  child: const Text(
                    "Enter verification code sent to your email/phone",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const TransparentDividerWidget(),

                //*****************OTP text field**********************
                TextFieldWidget(
                  label: 'otp',
                  obscure: false,
                  icon: Icons.mail,
                  controller: otpController,
                ),
                const TransparentDividerWidget(),
                //*****************************************************

                //***************Verify Button *********************** */
                StoreConnector<AppState, Future<void> Function()>(
                    converter: (store) {
                  return () async {
                    await store.dispatch(
                      VerifyUserAction(
                        store.state.partialUser!.email,
                        store.state.partialUser!.password,
                        otpController.value.text.trim(),
                      ),
                    );
                  };
                }, builder: (context, callback) {
                  return ButtonWidget(
                    text: "Verify",
                    function: () {
                      callback();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Login(store: store),
                        ),
                      );
                    },
                  );
                }),
                //*****************************************************
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, PopupWidget> {
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
