import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:general/widgets/dialog_helper.dart';
import 'package:general/widgets/divider.dart';
import 'package:redux_comp/actions/register_user_action.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:tradesman/widgets/place_bid_popup.dart';
import '../widgets/button.dart';
import '../widgets/circle_blur_widget.dart';
import '../widgets/divider.dart';
import '../widgets/link.dart';
import '../widgets/otp_pop_up.dart';
import '../widgets/textfield.dart';

class SignUpChoicePage extends StatelessWidget {
  final Store<AppState> store;

  const SignUpChoicePage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

                //*****************signup page****************************
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //*****************heading*****************************
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 65, 0, 0),
                        child: Text(
                          'Choose Your Role',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            letterSpacing: 5,
                          ),
                        ),
                      ),
                      //*************************************************

                      //*****************Tradesman Choice button**********************
                     Padding(
                        padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                        child: StoreConnector<AppState, _ViewModel>(
                          vm: () => _Factory(this),
                          builder: (BuildContext context, _ViewModel vm) =>
                              LongButtonWidget(
                            text: "Tradesman",
                            login: () => vm.pushSignUpPage(),
                          ),
                        ),
                      ),
                      //***************************************************

                      //*****************Consumer Choice button**********************
                     Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: StoreConnector<AppState, _ViewModel>(
                          vm: () => _Factory(this),
                          builder: (BuildContext context, _ViewModel vm) =>
                              LongButtonWidget(
                            text: "Client",
                            login: () => vm.pushSignUpPage(),
                          ),
                        ),
                      ),
                      //***************************************************

                      //*****************Sign In Link**********************
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 230, 0, 0),
                        child: StoreConnector<AppState, _ViewModel>(
                          vm: () => _Factory(this),
                          builder: (BuildContext context, _ViewModel vm) =>
                              LinkWidget(
                            text1: "Already have an account? ",
                            text2: "Sign In",
                            navigate: () => vm.pushLoginPage(),
                          ),
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
                      
                    //******************************************************* */
                    ],
                  ),
                ),
                //******************************************************* */
              ],
            ),
          ),
        ));
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, SignUpChoicePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchSignUpAction:
            (email, name, cell, location, password, isConsumer) => dispatch(
                RegisterUserAction(
                    email, name, cell, location, password, isConsumer)),
        pushLoginPage: () => dispatch(NavigateAction.pushNamed('/login')),
        pushSignUpPage: () => dispatch(NavigateAction.pushNamed('/signup')),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushLoginPage;
  final VoidCallback pushSignUpPage;
  final void Function(String, String, String, String, String, bool)
      dispatchSignUpAction;

  _ViewModel({
    required this.dispatchSignUpAction,
    required this.pushLoginPage,
    required this.pushSignUpPage,
  }); // implementing hashcode
}
