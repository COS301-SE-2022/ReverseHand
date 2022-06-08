// import 'package:amplify/models/Advert.dart';
import 'package:async_redux/async_redux.dart';
import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/divider.dart';
import 'package:redux_comp/actions/register_user_action.dart';
import 'package:redux_comp/app_state.dart';
import 'dart:ui';
import '../widgets/button.dart';
import '../widgets/circle_blur_widget.dart';
import '../widgets/divider.dart';
import '../widgets/link.dart';
import '../widgets/otp_pop_up.dart';
import '../widgets/textfield.dart';
import 'package:general/widgets/dialog_helper.dart';

class SignUp extends StatefulWidget {
  final Store<AppState> store;
  const SignUp({Key? key, required this.store}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cellController = TextEditingController();
  final locationController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    cellController.dispose();
    locationController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  String? Function(String?) createValidator(
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
    return Scaffold(
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

          //*****************signup page****************************
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //*****************heading*****************************
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      letterSpacing: 5,
                    ),
                  ),
                ),
                //*************************************************

                //*****************form****************************
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        //*****************name**********************
                        TextFieldWidget(
                            label: 'name',
                            obscure: false,
                            icon: Icons.account_circle_outlined,
                            controller: nameController,
                            validator: createValidator(
                                "name",
                                "must only be letters",
                                RegExp(
                                    r"/^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+$/u"))),
                        //********************************************
                        const TransparentDividerWidget(),
                        //*****************email**********************
                        TextFieldWidget(
                          label: 'email',
                          obscure: false,
                          icon: Icons.mail_outline_rounded,
                          controller: emailController,
                          validator: createValidator(
                              'email',
                              'is invalid',
                              RegExp(
                                  r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$')),
                        ),
                        //**********************************************
                        const TransparentDividerWidget(),
                        //*****************cellphone**********************
                        TextFieldWidget(
                          label: 'cellphone',
                          obscure: false,
                          icon: Icons.call_end_outlined,
                          controller: cellController,
                          validator: createValidator('cellphone',
                              'can only contain numbers', RegExp(r'')),
                        ),
                        //**********************************************
                        const TransparentDividerWidget(),
                        //*****************location**********************
                        TextFieldWidget(
                          label: 'location',
                          obscure: false,
                          icon: Icons.add_location_outlined,
                          controller: locationController,
                        ),
                        //**********************************************
                        const TransparentDividerWidget(),
                        //*****************password**********************
                        TextFieldWidget(
                          label: 'password',
                          obscure: true,
                          icon: Icons.lock_outline_rounded,
                          controller: passwordController,
                          validator: createValidator(
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
                        TextFieldWidget(
                          label: 'confirm password',
                          obscure: true,
                          icon: Icons.lock_outline_rounded,
                          controller: confirmController,
                          validator: createValidator(
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
                StoreConnector<AppState, ViewModel>(
                    vm: () => Factory(this),
                    //   converter: (store) {
                    //   return () async {
                    //     await store.dispatch(
                    //       RegisterUserAction(
                    //         emailController.value.text.trim(),
                    //         nameController.value.text.trim(),
                    //         cellController.value.text.trim(),
                    //         locationController.value.text.trim(),
                    //         passwordController.value.text.trim(),
                    //         "Consumer",
                    //       ),
                    //     );
                    //   };
                    // },
                    builder: (BuildContext context, ViewModel vm) {
                      return LongButtonWidget(
                        text: "Sign Up",
                        login: () {
                          if (_formKey.currentState!.validate()) {
                            callback();
                            DialogHelper.display(
                              context,
                              PopupWidget(
                                store: widget.store,
                              ),
                            ); //trigger OTP popup
                          }
                        },
                      );
                    }),
                //***************************************************

                //*****************"OR" divider"**********************
                SizedBox(
                  height: 30,
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
                StoreConnector<AppState, ViewModel>(
                  vm: () => Factory(this),
                  builder: (BuildContext context, ViewModel vm) => LinkWidget(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 20,
                      child: Text(
                        'or sign up with:',
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
              ],
            ),
          ),
          //******************************************************* */
        ],
      ),
    );
  }
}
