import 'package:amplify/models/Advert.dart';
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
              SizedBox(
                height: 20,
                child: Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        height: 150,
                        thickness: 2,
                        indent: 15,
                        endIndent: 15,
                        color: Colors.white,
                      ),
                    ),
                    Text("OR"),
                    Expanded(
                      child: Divider(
                        height: 150,
                        thickness: 2,
                        indent: 15,
                        endIndent: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // Row(
              //   children: const [
              //     Divider(
              //       height: 150,
              //       thickness: 2,
              //       indent: 15,
              //       endIndent: 220,
              //       color: Colors.black,
              //     ),
              //   ],
              // ),

              // Column(
              //   children: const [
              //     Text(
              //       'or',
              //       style: TextStyle(
              //         fontFamily: 'Segoe UI',
              //         fontSize: 17,
              //         color: Color(0xfff5fffa),
              //       ),
              //       softWrap: false,
              //     ),
              //   ],
              // ),

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
