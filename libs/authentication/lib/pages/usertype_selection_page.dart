import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:async_redux/async_redux.dart';
import 'package:authentication/widgets/circle_blur_widget.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:redux_comp/actions/init_amplify_action.dart';
import 'package:redux_comp/actions/user/cognito/add_user_to_group_action.dart';
import 'package:redux_comp/redux_comp.dart';
import '../widgets/auth_button.dart';
import '../widgets/transparent_divider.dart';

//************************************** */
//User not in group page
//************************************** */

class UserTypeSelectionPage extends StatelessWidget {
  final Store<AppState> store;
  const UserTypeSelectionPage({Key? key, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // configures amplify
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
              StoreConnector<AppState, _ViewModel>(
                vm: () => _Factory(this),
                builder: (BuildContext context, _ViewModel vm) =>
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
                                  child: AuthButtonWidget(
                                      text: "Contractor",
                                      function: () => vm
                                          .dispatchAddUserToGroup("tradesman")),
                                ),
                                //***************************************************/

                                const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                                ),

                                //*****************CONSUMER signup button**********************
                                AuthButtonWidget(
                                  text: "Client",
                                  function: () =>
                                      vm.dispatchAddUserToGroup("customer"),
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
        dispatchAddUserToGroup: (String group) => dispatch(
          AddUserToGroupAction(state.userDetails.externalUsername!, group),
        ),
        pushSignUpPage: () => dispatch(NavigateAction.pushNamed('/signup')),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(String) dispatchAddUserToGroup;
  final bool loading;
  final VoidCallback pushSignUpPage;

  _ViewModel({
    required this.dispatchAddUserToGroup,
    required this.loading,
    required this.pushSignUpPage,
  }) : super(equals: [loading]); 
}
