import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:authentication/widgets/circle_blur_widget.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:redux_comp/actions/init_amplify_action.dart';
import 'package:redux_comp/actions/user/signin_facebook_action.dart';
import 'package:redux_comp/models/error_type_model.dart';
import 'package:redux_comp/redux_comp.dart';
import '../widgets/auth_button.dart';
import '../widgets/transparent_divider.dart';

//************************************** */
//User not in group page for Google or 
//Facebook login
//************************************** */

class UserTypeSelectionPage extends StatelessWidget {
  final Store<AppState> store;
  const UserTypeSelectionPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // confugures amplify
    if (!Amplify.isConfigured) {
      store.dispatch(InitAmplifyAction());
    }

    return StoreProvider<AppState>(
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
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //*****************form****************************
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(top: 250),
                              ),

                              const Text(
                                "Continue as:",
                                style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 5,
                                  ),
                              ),

                              const TransparentDividerWidget(),
                              //*****************TRADESMAN signup button**********************
                              Align(
                                alignment: Alignment.center,
                                child:  StoreConnector<AppState, _ViewModel>(
                                vm: () => _Factory(this),
                                builder: (BuildContext context, _ViewModel vm) =>
                                  AuthButtonWidget(
                                    text: "Contractor",
                                    function: () {
                                      //tradesman function
                                    },
                                  ),
                                ),
                              ),
                              //***************************************************/

                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                              ),

                              //*****************CONSUMER signup button**********************
                               StoreConnector<AppState, _ViewModel>(
                                vm: () => _Factory(this),
                                builder: (BuildContext context, _ViewModel vm) =>
                                    AuthButtonWidget(
                                    text: "Client",
                                    function: () => {
                                      //consumer function
                                    },
                                  ),
                               ),
                              //***************************************************/
                            ],
                          ),
                        ),
                        //******************************************************* */
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, UserTypeSelectionPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        error: state.error,
        dispatchSignInFacebook: () => dispatch(
          SigninFacebookAction(),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function() dispatchSignInFacebook;
  final bool loading;
  final ErrorType error;

  _ViewModel({
    required this.dispatchSignInFacebook,
    required this.loading,
    required this.error,
  }) : super(equals: [loading, error]); // implementing hashcode
}
