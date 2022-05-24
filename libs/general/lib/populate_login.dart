// import 'package:amplify/models/Advert.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';
import 'dart:ui';

class Login extends StatelessWidget {
  final Store<AppState> store;
  const Login({Key? key, required this.store}) : super(key: key);

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
          //******************************************************* */
        
          //*****************Divider********************************
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //*****************LOGO**********************
              const Center(
                child: Text("LOGO HERE"),
              ),
              //********************************************
           
              //*****************form**********************
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    //*****************email**********************
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'email',
                        labelStyle: const TextStyle(color: Colors.orange),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        enabledBorder: OutlineInputBorder( 
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.orange,
                            width: 2.0,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.mail_outline_rounded,
                        ),
                      ),
                    ),
                    //*******************************************
                      const Divider(
                        height: 15,
                        thickness: 0.5,
                        indent: 15,
                        endIndent: 10,
                        color: Colors.transparent,
                      ),
                    //*****************password**********************
                   TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'password',
                        labelStyle: const TextStyle(color: Colors.orange),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        enabledBorder: OutlineInputBorder( 
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.orange,
                            width: 2.0,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                        ),
                      ),
                    ),
                    //********************************************

                  ],
                 ),
              ),
              //********************************************


              //*****************login swipe**********************
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor,),
                ),
                onPressed: () { },
                child: const Text('Login'),
              ),
              //********************************************

              SizedBox(
                height: 20,
                child: Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        height: 150,
                        thickness: 0.5,
                        indent: 15,
                        endIndent: 10,
                        color: Colors.white,
                      ),
                    ),
                    Text("or"),
                    Expanded(
                      child: Divider(
                        height: 150,
                        thickness: 0.5,
                        indent: 10,
                        endIndent: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              //******************************************************* */

              //*****************Sign up Link**********************
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xfff5fffa),
                      ),
                      softWrap: false,
                    ),
                  ),
                  Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).primaryColor,
                      ),
                      softWrap: false,
                    ),
                  ),
                ],
              ),
           
          //******************************************************* */

          //*******************sign in with text************************** */
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 20,
                    child: Text(
                      'or sign in with:',
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

          //*****************Bottom circle blur**********************
          // Container(
          //   width: 100,
          //   height: 100,
          //   margin: EdgeInsets.all(0),
          //   padding: EdgeInsets.only(top: 2),
          //   alignment: Alignment.bottomRight,
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).primaryColor,
          //     borderRadius:
          //     BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
          //   ),
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 60.0),
          //     child: Container(
          //       decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
          //     ),
          //   ),
          // ),
          //******************************************************* */
        ],
      ),
    );
  }
}
