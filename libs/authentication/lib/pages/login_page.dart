import 'dart:ui';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:authentication/widgets/circle_blur_widget.dart';
import 'package:authentication/widgets/textfield.dart';
import 'package:consumer/pages/job_listings.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:general/widgets/divider.dart';
import 'package:redux_comp/actions/init_amplify_action.dart';
import 'package:redux_comp/actions/view_adverts_action.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:tradesman/pages/job_listings.dart';
import '../widgets/button.dart';
import '../widgets/link.dart';
import 'sign_up.dart';

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
      child: StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          theme: CustomTheme.darkTheme,
          home: Scaffold(
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
                          TextFieldWidget(
                            label: 'email',
                            obscure: false,
                            icon: Icons.mail_outline_rounded,
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
                          TextFieldWidget(
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

                    StoreConnector<AppState, ViewModel>(
                      vm: () => Factory(this),
                      builder: (BuildContext context, ViewModel vm) {
                        if (!vm.loading) {
                          if (store.state.user!.userType == "Consumer") {
                            // store.dispatch(ViewAdvertsAction(
                            //     store.state.user!.id));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ConsumerListings(store: store),
                              ),
                            );
                          } else if (store.state.user!.userType ==
                              "Tradesman") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    TradesmanJobListings(store: store),
                              ),
                            );
                          }
                        }

                        return LongButtonWidget(
                          text: "Login",
                          login: () {
                            vm.dispatchLoginAction(
                              emailController.value.text.trim(),
                              passwordController.value.text.trim(),
                            );
                          },
                        );
                      },
                    ),
                    /*StoreConnector<AppState, Future<void> Function()>(
                        converter: (store) {
                      return () async {
                        await store.dispatch(
                          // LogoutAction()
                          LoginAction(
                            emailController.value.text.trim(),
                            passwordController.value.text.trim(),
                          ),
                        );
                      };
                    }, builder: (context, callback) {
                      return LongButtonWidget(
                        text: "Login",
                        login: () {
                          callback().whenComplete(() {
                            if (store.state.user == null) {
                            } else if (store.state.user!.userType ==
                                "Consumer") {
                              store.dispatch(
                                  ViewAdvertsAction(store.state.user!.id));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ConsumerListings(store: store),
                                ),
                              );
                            } else if (store.state.user!.userType ==
                                "Tradesman") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      TradesmanJobListings(store: store),
                                ),
                              );
                            }
                          });
                        },
                      );
                    }),*/
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
                    LinkWidget(
                        text1: "Don't have an account? ",
                        text2: "Sign Up",
                        navigate: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignUpPage(store: store)),
                              )
                            }),
                    //******************************************************* */

                    //*****************Sign up Link**********************
                    // const LinkWidget(text1: "Sign Up", text2: "", link: ""),

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
                  ],
                ),
                //******************************************************* */
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// factory for view model
class Factory extends VmFactory<AppState, LoginPage> {
  Factory(widget) : super(widget);

  @override
  ViewModel fromStore() => ViewModel(
        loading: state.loading,
        userType: state.user!.userType,
        dispatchLoginAction: (String email, String password) => dispatch(
          LoginAction(email, password),
        ),
      );
}

// view model
class ViewModel extends Vm {
  final bool loading;
  final String userType;
  final void Function(String, String) dispatchLoginAction;

  ViewModel({
    required this.loading,
    required this.userType,
    required this.dispatchLoginAction,
  }) : super(equals: [loading]); // implementinf hashcode
}
