// import 'package:amplify/models/Advert.dart';
import 'package:async_redux/async_redux.dart';
import 'package:authentication/authentication.dart';
import 'package:consumer/pages/job_listings.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:general/widgets/divider.dart';
import 'package:redux_comp/actions/login_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:tradesman/pages/job_listings.dart';
import 'dart:ui';
import '../widgets/button.dart';
import '../widgets/link.dart';
import '../widgets/textfield.dart';

class Login extends StatefulWidget {
  final Store<AppState> store;
  const Login({Key? key, required this.store}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.store.state.user == null)
      {}
    else if (widget.store.state.user!.userType == "Consumer") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ConsumerListings(
                store:
                    widget.store)), //comment to rather view tradesman
      );
    }
    else if (widget.store.state.user!.userType == "tradesman") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => TradesmanJobListings(
                store:
                    widget.store)), //uncomment to view tradesman
      );
    }
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
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
              //*******************************************************

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
                  //to be fixed in coming days
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
                            controller: emailController),
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
                          controller: passwordController,
                        ),
                        //**********************************************
                      ],
                    ),
                  ),
                  //****************************************************

                  //*****************login button**********************

                  StoreConnector<AppState, VoidCallback>(converter: (store) {
                    return () => store.dispatch(
                        // LogoutAction()
                        LoginAction(emailController.value.text.trim(),
                            passwordController.value.text.trim()));
                  }, builder: (context, callback) {
                    return LongButtonWidget(
                      text: "login",
                      login: () => {
                        callback(),
                      },
                    );
                  }),
                  //***************************************************

                  //*****************Sign up Link**********************
                  LinkWidget(
                      text1: "Don't have an account? ",
                      text2: "Sign Up",
                      navigate: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SignUpPage(store: widget.store)),
                            )
                          }),
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
            ],
          ),
          //******************************************************* */

          //*****************Bottom circle blur**********************
          //to be fixed in coming days
          //******************************************************* */
        ),
      ),
    );
  }
}
