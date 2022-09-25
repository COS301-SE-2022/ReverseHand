import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:authentication/widgets/circle_blur_widget.dart';
import 'package:authentication/widgets/divider_widget.dart';
import 'package:authentication/widgets/auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/init_amplify_action.dart';
import 'package:redux_comp/actions/user/amplify_auth/login_action.dart';
import 'package:redux_comp/actions/user/signin_facebook_action.dart';
import 'package:redux_comp/actions/user/signin_google_action.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/redux_comp.dart';
import '../widgets/auth_button.dart';
import '../widgets/forgot_password_popups/email_popup_widget.dart';
import '../widgets/link_widget.dart';
import '../widgets/otp_pop_up.dart';

class LoginPage extends StatelessWidget {
  final Store<AppState> store;
  LoginPage({Key? key, required this.store}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // confugures amplify
    if (!Amplify.isConfigured) {
      store.dispatch(InitAmplifyAction());
    }

    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            //*****************Top circle blur**********************
            const CircleBlurWidget(),
            //*******************************************************

            //*****************Bottom circle blur**********************
            const Align(
              alignment: Alignment.bottomRight,
              child: CircleBlurWidget(),
            ),
            //******************************************************* */
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //*****************LOGO*****************************
                      const Padding(padding: EdgeInsets.only(top: 45),),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 245,
                          width: 245,
                          package: 'authentication',
                        ),
                      ),
                      //*************************************************

                      //*****************form****************************
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child: Column(
                          children: <Widget>[
                            //*****************email**********************
                            AuthTextFieldWidget(
                              label: 'email',
                              obscure: false,
                              icon: Icons.alternate_email_outlined,
                              controller: emailController,
                            ),
                            //********************************************
                            const Divider(
                              height: 20,
                              thickness: 0.5,
                              indent: 15,
                              endIndent: 10,
                              color: Colors.transparent,
                            ),
                            //*****************password**********************
                            AuthTextFieldWidget(
                              label: 'password',
                              obscure: true,
                              icon: Icons.lock_outline_rounded,
                              controller: passwordController,
                            ),
                            //**********************************************
                          ],
                        ),
                      ),
                      //****************************************************

                      //*****************login button**********************

                      StoreConnector<AppState, _ViewModel>(
                        vm: () => _Factory(this),
                        builder: (BuildContext context, _ViewModel vm) =>
                            vm.loading
                                ? const LoadingWidget(
                                    topPadding: 5, bottomPadding: 15)
                                : AuthButtonWidget(
                                    text: "Login",
                                    function: () {
                                      vm.dispatchLoginAction(
                                        emailController.value.text.trim(),
                                        passwordController.value.text.trim(),
                                      );
                                    },
                                  ),
                      ),
                      //***************************************************

                      StoreConnector<AppState, _ViewModel>(
                        vm: () => _Factory(this),
                        builder: (BuildContext context, _ViewModel vm) =>
                            (vm.error == ErrorType.userNotVerified)
                                ? OTPPopupWidget(
                                    store: store,
                                  )
                                : Container(),
                      ),

                      //*****************Forgot password**********************
                      StoreConnector<AppState, _ViewModel>(
                        vm: () => _Factory(this),
                        builder: (BuildContext context, _ViewModel vm) =>
                            Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) =>
                                    FPEmailPopupWidget(
                                  store: store,
                                ),
                              );
                            }, //forgot password popup linked here
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey,
                              ),
                              softWrap: false,
                            ),
                          ),
                        ),
                      ),
                      //******************************************************* */

                      //*****************"OR" divider"**********************
                      SizedBox(
                        height: 50,
                        child: Row(
                          children: const [
                            Expanded(
                              child: DividerWidget(),
                            ),
                            Text("or"),
                            Expanded(
                              child: DividerWidget(),
                            ),
                          ],
                        ),
                      ),
                      //****************************************************** */

                      //*****************Sign up Link**********************
                      StoreConnector<AppState, _ViewModel>(
                        vm: () => _Factory(this),
                        builder: (BuildContext context, _ViewModel vm) =>
                            LinkWidget(
                                text1: "Don't have an account? ",
                                text2: "Sign Up",
                                navigate: () => vm.pushSignUpPage(),
                                colour: Colors.grey),
                      ),
                      //******************************************************* */

                      const Divider(
                        height: 20,
                        thickness: 0.5,
                        indent: 15,
                        endIndent: 10,
                        color: Colors.transparent,
                      ),
                      //*******************sign in with text************************** */
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 20,
                            child: Text(
                              'or login with:',
                              style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 15,
                                color: Color(0x7df5fffa),
                              ),
                              softWrap: false,
                            ),
                          ),
                        ],
                      ),
                      //**********************************************************************/
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      //*******************sign in with image elements************************** */
                      StoreConnector<AppState, _ViewModel>(
                        vm: () => _Factory(this),
                        builder: (BuildContext context, _ViewModel vm) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                //Facebook
                                GestureDetector(
                                  onTap:
                                      vm.dispatchSignInFacebook, // Image tapped
                                  child: const Align(
                                    alignment: Alignment.bottomLeft,
                                    child: CircleAvatar(
                                        radius: 20, // Image radius
                                        backgroundImage: AssetImage(
                                            "assets/images/facebook.png",
                                            package: 'authentication')),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(left: 25)),
                            Column(
                              children: [
                                //Google
                                GestureDetector(
                                  onTap:
                                      vm.dispatchSignInGoogle, // Image tapped
                                  child: const Align(
                                    alignment: Alignment.bottomRight,
                                    child: CircleAvatar(
                                        radius: 20, // Image radius
                                        backgroundImage: AssetImage(
                                            "assets/images/google.png",
                                            package: 'authentication')),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //******************************************************* */
                    ],
                  ),
                  //******************************************************* */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, LoginPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        error: state.error,
        loading: state.wait.isWaiting,
        pushSignUpPage: () => dispatch(NavigateAction.pushNamed('/signup')),
        dispatchLoginAction: (String email, String password) => dispatch(
          LoginAction(email, password),
        ),
        dispatchSignInFacebook: () => dispatch(SigninFacebookAction()),
        dispatchSignInGoogle: () => dispatch(SignInGoogleAction()),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(String, String) dispatchLoginAction;
  final void Function() dispatchSignInFacebook;
  final void Function() dispatchSignInGoogle;
  final VoidCallback pushSignUpPage;
  final bool loading;
  final ErrorType error;

  _ViewModel({
    required this.dispatchLoginAction,
    required this.dispatchSignInFacebook,
    required this.dispatchSignInGoogle,
    required this.loading,
    required this.error,
    required this.pushSignUpPage,
  }) : super(equals: [loading]);
}
