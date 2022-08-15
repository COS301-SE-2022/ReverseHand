import 'package:async_redux/async_redux.dart';
import 'package:authentication/widgets/divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:general/widgets/dark_dialog_helper.dart';
import 'package:redux_comp/actions/user/amplify_auth/register_user_action.dart';
import 'package:redux_comp/redux_comp.dart';
import '../widgets/auth_button.dart';
import '../widgets/circle_blur_widget.dart';
import '../widgets/transparent_divider.dart';
import '../widgets/link_widget.dart';
import '../widgets/otp_pop_up.dart';
import '../widgets/auth_textfield.dart';

//************************************** */
//Consumer sign up page
//************************************** */

class SignUpPage extends StatefulWidget {
  final Store<AppState> store;

  const SignUpPage({Key? key, required this.store}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // controllers for retrieveing text
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cellController = TextEditingController();
  final tradeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  // used for validation
  final _consumerFormKey = GlobalKey<FormState>();

  String? Function(String?) _createValidator(
      String kind, String invalidMsg, RegExp regex) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'A $kind must be entered';
      }

      if (!regex.hasMatch(value)) {
        return "${kind[0].toUpperCase() + kind.substring(1)} $invalidMsg";
      }

      return null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: Scaffold(
            body: Stack(
              children: <Widget>[
                //*****************SignUp**********************
                Stack(
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

                    //*****************signup page****************************
                    SingleChildScrollView(
                      child: Column(
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
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  //*****************email**********************
                                  AuthTextFieldWidget(
                                    label: 'email',
                                    obscure: false,
                                    icon: Icons.alternate_email_outlined,
                                    controller: emailController,
                                    validator: _createValidator(
                                        'email',
                                        'is invalid',
                                        RegExp(
                                            r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')),
                                  ),
                                  //**********************************************
                                  const TransparentDividerWidget(),
                                  //*****************password**********************
                                  AuthTextFieldWidget(
                                    label: 'password',
                                    obscure: true,
                                    icon: Icons.lock_open_outlined,
                                    controller: passwordController,
                                    validator: _createValidator(
                                      'password',
                                      'must be at least 8 characters with upper and lowercase, atleast one number and special character',
                                      RegExp(
                                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                                      ),
                                    ),
                                  ),
                                  //**********************************************
                                  const TransparentDividerWidget(),
                                  //*****************confirm password**********************
                                  AuthTextFieldWidget(
                                    label: 'confirm password',
                                    obscure: true,
                                    icon: Icons.lock_outline_rounded,
                                    controller: confirmController,
                                    validator: _createValidator(
                                      'password',
                                      'must be at least 8 characters with upper and lowercase, atleast one number and special character',
                                      RegExp(
                                        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                                      ),
                                    ),
                                  ),
                                  //**********************************************
                                ],
                              ),
                            ),
                          ),
                          //****************************************************

                          //*****************signup button**********************
                          StoreConnector<AppState, _ViewModel>(
                            vm: () => _Factory(this),
                            builder: (BuildContext context, _ViewModel vm) =>
                                AuthButtonWidget(
                              text: "Sign Up",
                              function: () {
                                if (_consumerFormKey.currentState!.validate()) {
                                  vm.dispatchSignUpAction(
                                    emailController.value.text.trim(),
                                    nameController.value.text.trim(),
                                    cellController.value.text.trim(),
                                    passwordController.value.text.trim(),
                                    true, // comment true for Consumer
                                  );

                                  DarkDialogHelper.display(
                                    context,
                                    PopupWidget(
                                      store: widget.store,
                                    ),
                                  ); //trigger OTP popup
                                }
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

                          //*****************Sign in Link**********************
                          StoreConnector<AppState, _ViewModel>(
                            vm: () => _Factory(this),
                            builder: (BuildContext context, _ViewModel vm) =>
                                LinkWidget(
                              text1: "Already have an account? ",
                              text2: "Sign In",
                              navigate: () => vm.pushLoginPage(),
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
                        ],
                      ),
                    ),
                    //******************************************************* */
                  ],
                ),
                //******************************************************
                //*****************************************************

                //*******************************************************
              ],
            ),
          ),
        ),
        //*******************************************************
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, _SignUpPageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchSignUpAction:
            (email, name, cell, password, isConsumer) =>
                dispatch(RegisterUserAction(email, password, isConsumer)),
        pushLoginPage: () => dispatch(NavigateAction.pushNamed('/login')),
        pushLocationPage: () => dispatch(NavigateAction.pushNamed('/location')),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushLoginPage;
  final VoidCallback pushLocationPage;
  final void Function(String, String, String, String, bool)
      dispatchSignUpAction;

  _ViewModel({
    required this.dispatchSignUpAction,
    required this.pushLoginPage,
    required this.pushLocationPage,
  }); // implementing hashcode
}
