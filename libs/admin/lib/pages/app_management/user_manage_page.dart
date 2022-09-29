import 'package:admin/widgets/admin_user_widget.dart';
import 'package:admin/widgets/partial_user_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:redux_comp/actions/admin/app_management/enable_user_action.dart';
import 'package:redux_comp/models/admin/app_management/models/admin_user_model.dart';
import 'package:redux_comp/models/admin/app_management/models/cognito_user_model.dart';
import 'package:redux_comp/redux_comp.dart';

class UserManagePage extends StatelessWidget {
  final Store<AppState> store;
  const UserManagePage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CognitoUserModel? cogUser =
        ModalRoute.of(context)?.settings.arguments as CognitoUserModel?;

    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            Widget appbar = AppBarWidget(
              title: "User Management",
              store: store,
              backButton: true,
            );
            return (vm.loading)
                ? Column(
                    children: [
                      //**********APPBAR***********//
                      appbar,
                      //*******************************************//

                      LoadingWidget(
                          topPadding: MediaQuery.of(context).size.height / 3,
                          bottomPadding: 0)
                    ],
                  )
                : Column(
                    children: [
                      //**********APPBAR***********//
                      appbar,

                      (vm.activeUser != null)
                          ? AdminUserWidget(user: vm.activeUser!)
                          : PartialUserWidget(user: cogUser!),
                      const Padding(padding: EdgeInsets.only(bottom: 25)),
                      LongButtonWidget(
                          text: (vm.activeUser?.enabled ?? cogUser!.enabled)
                              ? "Disable User"
                              : "Enable User",
                          function: (vm.activeUser?.enabled ?? cogUser!.enabled)
                              ? () {
                                  (cogUser != null)
                                      ? vm.dispatchEnableUser(
                                          username: cogUser!.cognitoUsername,
                                          disable: true,
                                          user: cogUser)
                                      : vm.dispatchEnableUser(
                                          username:
                                              vm.activeUser!.cognitoUsername,
                                          disable: true,
                                        );
                                  cogUser = cogUser?.copy(enabled: false);
                                }
                              : () {
                                  (cogUser != null)
                                      ? vm.dispatchEnableUser(
                                          username: cogUser!.cognitoUsername,
                                          disable: false,
                                          user: cogUser)
                                      : vm.dispatchEnableUser(
                                          username:
                                              vm.activeUser!.cognitoUsername,
                                          disable: false,
                                        );
                                  cogUser = cogUser?.copy(enabled: true);
                                }),
                      const Padding(padding: EdgeInsets.only(bottom: 10)),
                      // TransparentLongButtonWidget(
                      //     text: "Delete User",
                      //     borderColor: Colors.red,
                      //     function: () {
                      //       showModalBottomSheet(
                      //           context: context,
                      //           isScrollControlled: true,
                      //           builder: (BuildContext context) => SizedBox(
                      //                 height: 180,
                      //                 child: Column(
                      //                   children: [
                      //                     const Center(
                      //                       child: Padding(
                      //                         padding: EdgeInsets.all(18.0),
                      //                         child: Text(
                      //                           "Are you sure you want to delete this user's account?",
                      //                           textAlign: TextAlign.center,
                      //                           style: TextStyle(
                      //                               color: Colors.black,
                      //                               fontSize: 20),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     Row(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                       children: [
                      //                         ButtonWidget(
                      //                             text: "Delete",
                      //                             function: () {}),
                      //                         const Padding(
                      //                             padding: EdgeInsets.only(
                      //                                 right: 10)),
                      //                         ButtonWidget(
                      //                             text: "Cancel",
                      //                             color: "light",
                      //                             border: "lightBlue",
                      //                             function: () {
                      //                               Navigator.pop(context);
                      //                             }),
                      //                       ],
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ));
                      //     })
                    ],
                  );
          },
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, UserManagePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        activeUser: state.admin.adminManage.activeUser,
        dispatchEnableUser: ({required username, required disable, user}) {
          dispatch(
            EnableUserAction(
              username: username,
              disable: disable,
              user: user,
            ),
          );
        },
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final AdminUserModel? activeUser;
  final void Function(
      {required String username,
      required bool disable,
      CognitoUserModel? user}) dispatchEnableUser;

  _ViewModel({
    required this.loading,
    required this.activeUser,
    required this.dispatchEnableUser,
  }) : super(equals: [loading, activeUser]); // implementinf hashcode;
}
