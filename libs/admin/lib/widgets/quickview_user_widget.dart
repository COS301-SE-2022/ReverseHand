import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/admin/app_management/admin_get_user_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/admin/app_management/models/cognito_user_model.dart';

//*********************************************** */
// Reported Customers card layout widget
//*********************************************** */

class QuickViewUserCardWidget extends StatelessWidget {
  final CognitoUserModel user; // Current user
  final Store<AppState> store;

  const QuickViewUserCardWidget({
    Key? key,
    required this.user,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(this),
        builder: (BuildContext context, _ViewModel vm) => InkWell(
          onTap: () {
            vm.dispatchGetUser(user.id);
            vm.pushUserManage();
          },
          child: Card(
            margin: const EdgeInsets.all(10),
            // color: Theme.of(context).primaryColorLight,
            color: const Color.fromARGB(255, 220, 224, 230),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            elevation: 2,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.email,
                            color: Colors.black,
                            size: 25.0,
                          ),
                          const Padding(padding: EdgeInsets.only(right: 5)),
                          Text(
                            user.email,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 4, 5, 2),
                          child: Row(children: [
                            Text(
                              user.enabled ? "ENABLED" : "DISABLED",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            const Padding(padding: EdgeInsets.only(right: 5)),
                            Icon(
                              (user.enabled ? Icons.check : Icons.close),
                              size: 15,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 10)),
                            Text(
                              user.status,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                            ),
                            const Padding(padding: EdgeInsets.only(right: 5)),
                            Icon(
                              (user.status == "EXTERNAL_PROVIDER" ? Icons.arrow_forward_ios_outlined : Icons.check),
                              // color: ,
                              size: 15,
                            ),
                          ])),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, QuickViewUserCardWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
    pushUserManage: () =>  dispatch(NavigateAction.pushNamed("/user_manage")),
    dispatchGetUser: (userId) => dispatch(AdminGetUserAction(userId))
  );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushUserManage;
  final void Function(String) dispatchGetUser;
  _ViewModel({
    required this.pushUserManage,
    required this.dispatchGetUser
  });
}
