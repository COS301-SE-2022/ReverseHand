import 'package:async_redux/async_redux.dart';
import 'package:authentication/widgets/transparent_divider.dart';
import 'package:authentication/widgets/auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/blue_button_widget.dart';
import 'package:general/widgets/button.dart';
import 'package:redux_comp/actions/user/amplify_auth/verify_user_action.dart';
import 'package:redux_comp/app_state.dart';

import '../../pages/login_page.dart';
import '../auth_textfield_light.dart';
import '../link_widget.dart';
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
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        color: const Color.fromARGB(255, 232, 232, 232),
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 300,
              child: Column(
                children: [
                  const Text("Enter email to receive OTP",
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  const Padding(padding: EdgeInsets.all(10)),
                  //*****************Email text field**********************
                  Container(
                    margin: const EdgeInsets.only(left: 25, right: 25),
                    padding: const EdgeInsets.all(8.0),
                    child: AuthTextFieldLightWidget(
                      label: 'email',
                      obscure: false,
                      icon: Icons.email_outlined, 
                      controller: emailController,
                      
                    ),
                  ),
                  //*****************************************************

                  //*****************Heading **********************
                  const Padding(padding: EdgeInsets.all(20)),
                  ButtonWidget(text: "Send", function: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) =>
                        FPOTPPopupWidget(store: store,),
                      );
                  })
                ],
              ),
            )),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, FPEmailPopupWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchVerifyUserAction: (email) => dispatch(VerifyUserAction(email)),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(String) dispatchVerifyUserAction;

  _ViewModel({
    required this.dispatchVerifyUserAction,
  }); 
}
