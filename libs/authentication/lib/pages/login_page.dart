import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:authentication/widgets/circle_blur_widget.dart';
import 'package:authentication/widgets/divider_widget.dart';
import 'package:authentication/widgets/auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/init_amplify_action.dart';
import 'package:redux_comp/actions/intiate_auth_action.dart';
import 'package:redux_comp/actions/user/signin_facebook_action.dart';
import 'package:redux_comp/actions/toast_error_action.dart';
import 'package:redux_comp/actions/user/login_action.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/redux_comp.dart';
import '../widgets/auth_button.dart';
import '../widgets/link_widget.dart';

class LoginPage extends StatelessWidget {
  final Store<AppState> store;
  LoginPage({Key? key, required this.store}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 250,
                          width: 250,
                          package: 'authentication',
                        ),
                      ),
                      //*************************************************

                      //*****************form****************************
                      Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.all(20),
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
                        onDidChange: (context, store, vm) {
                          final String msg;
                          switch (store.state.error) {
                            case ErrorType.none:
                              return;
                            case ErrorType.userNotFound:
                              msg = "User not found";
                              break;
                            case ErrorType.userNotVerified:
                              msg = "User not verified";
                              break;
                            case ErrorType.userInvalidPassword:
                              msg = "Invalid login credentials";
                              break;
                            case ErrorType.passwordAttemptsExceeded:
                              msg = "Max number of password attempts exceeded";
                              break;
                            case ErrorType.noInput:
                              msg = "Please input a username and password";
                              break;
                            default:
                              msg = "How did we get here?";
                              break;
                          }

                          store.dispatch(ToastErrorAction(context!, msg));
                        },
                        builder: (BuildContext context, _ViewModel vm) =>
                            vm.loading
                                ? const LoadingWidget()
                                : AuthButtonWidget(
                                    text: "Login",
                                    function: () {
                                      vm.dispatchLoginAction(
                                        emailController.value.text.trim(),
                                        passwordController.value.text.trim(),
                                      );
                                      // Location l = const Location(address: Address(streetNumber: "1",street: "2", city: "3", province: "4", zipCode: "6"), coordinates: Coordinates(lat: 1, lng: 1));
                                      // vm.dispatchEditUserAction("Richard", l);
                                    },
                                  ),
                      ),
                      //***************************************************

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
                        ),
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
                                fontSize: 12,
                                color: Color(0x7df5fffa),
                              ),
                              softWrap: false,
                            ),
                          ),
                        ],
                      ),
                      //**********************************************************************/

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
                                  onTap: () {}, // Image tapped
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Image.asset(
                                      'assets/images/facebook.png',
                                      height: 100,
                                      width: 100,
                                      package: 'authentication',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                //Google
                                GestureDetector(
                                  onTap:
                                      vm.dispatchSignInFacebook, // Image tapped
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Image.asset(
                                      'assets/images/google.png',
                                      height: 100,
                                      width: 100,
                                      package: 'authentication',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                //Apple
                                //Shouldn't always display, figure out device being used: todo
                                GestureDetector(
                                  onTap: () {}, // Image tapped
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Image.asset(
                                      'assets/images/apple.png',
                                      height: 100,
                                      width: 100,
                                      package: 'authentication',
                                    ),
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
        loading: state.wait.isWaiting,
        pushSignUpPage: () => dispatch(NavigateAction.pushNamed('/signup')),
        dispatchLoginAction: (String email, String password) => dispatch(
          LoginAction(email, password),
        ),
        error: state.error,
        dispatchSignInFacebook: () => dispatch(
          IntiateAuthAction(),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(String, String) dispatchLoginAction;
  final void Function() dispatchSignInFacebook;
  final VoidCallback pushSignUpPage;
  final bool loading;
  final ErrorType error;

  _ViewModel({
    required this.dispatchLoginAction,
    required this.dispatchSignInFacebook,
    required this.loading,
    required this.pushSignUpPage,
    required this.error,
  }) : super(equals: [loading, error]); 
}
