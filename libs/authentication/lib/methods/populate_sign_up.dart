// import 'package:amplify/models/Advert.dart';

import 'package:async_redux/async_redux.dart';
import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/divider.dart';
import 'package:redux_comp/actions/register_user_action.dart';
import 'package:redux_comp/app_state.dart';
import 'dart:ui';
import '../widgets/button.dart';
import '../widgets/divider.dart';
import '../widgets/link.dart';
import '../widgets/otp_pop_up.dart';
import '../widgets/textfield.dart';
import 'package:general/widgets/dialog_helper.dart';

class SignUp extends StatelessWidget {
  final Store<AppState> store;
  SignUp({Key? key, required this.store}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cellController = TextEditingController();
  final locationController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    cellController.dispose();
    locationController.dispose();
    passwordController.dispose();
    confirmController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          //*****************Top circle blur**********************
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.all(0),
            padding: const EdgeInsets.only(top: 2),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius:
                  const BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 60.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          //*******************************************************

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
                  child: Column(
                    children: <Widget>[
                      //currently only created for consumer sign-up
                      //*****************name**********************
                      TextFieldWidget(
                        label: 'name',
                        obscure: false,
                        controller: nameController,
                      ),
                      //********************************************
                      const TransparentDividerWidget(),
                      //*****************email**********************
                      TextFieldWidget(
                        label: 'email',
                        obscure: false,
                        controller: emailController,
                      ),
                      //**********************************************
                      const TransparentDividerWidget(),
                      //*****************cellphone**********************
                      TextFieldWidget(
                          label: 'cellphone',
                          obscure: false,
                          controller: cellController),
                      //**********************************************
                      const TransparentDividerWidget(),
                      //*****************location**********************
                      TextFieldWidget(
                          label: 'location',
                          obscure: false,
                          controller: locationController),
                      //**********************************************
                      const TransparentDividerWidget(),
                      //*****************password**********************
                      TextFieldWidget(
                          label: 'password',
                          obscure: true,
                          controller: passwordController),
                      //**********************************************
                      const TransparentDividerWidget(),
                      //*****************confirm password**********************
                      TextFieldWidget(
                          label: 'confirm password',
                          obscure: true,
                          controller: confirmController),
                      //**********************************************
                    ],
                  ),
                ),
                //****************************************************

                //*****************signup button**********************
                StoreConnector<AppState, Future<void> Function()>(
                    converter: (store) {
                  return () async => {
                        await store.dispatch(
                          RegisterUserAction(
                            emailController.value.text.trim(),
                            nameController.value.text.trim(),
                            cellController.value.text.trim(),
                            locationController.value.text.trim(),
                            passwordController.value.text.trim(),
                            "Consumer",
                          ),
                        ),
                      };
                }, builder: (context, callback) {
                  return LongButtonWidget(
                    text: "Sign Up",
                    login: () => {
                      callback(),
                      DialogHelper.display(
                          context,
                          PopupWidget(
                            store: store,
                          )), //trigger OTP popup
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

                LinkWidget(
                    text1: "Already have an account? ",
                    text2: "Sign In",
                    navigate: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => LoginPage(store: store)),
                          )
                        }),
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

          //*****************Bottom circle blur**********************
          //to be fixed in coming days
          //******************************************************* */
        ],
      ),
    );
  }
}
