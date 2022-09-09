import 'package:admin/widgets/admin_appbar_widget.dart';
import 'package:admin/widgets/admin_navbar_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/models/admin/cognito_user_model.dart';
import 'package:redux_comp/models/user_models/cognito_auth_model.dart';
import 'package:redux_comp/redux_comp.dart';

class AdminUserManagePage extends StatelessWidget {
  final Store<AppState> store;
  final CognitoUserModel user = const CognitoUserModel(
      id: "c#001", email: "lastrucci61@gmail.com", enabled: true);
  const AdminUserManagePage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) {
              Widget appBar = AdminAppBarWidget(
                title: "Manage User",
                store: store,
                backButton: true,
              );
              return (vm.loading)
                  ? Column(
                      children: [
                        //**********APPBAR***********//
                        appBar,
                        //*******************************************//

                        LoadingWidget(
                            padding: MediaQuery.of(context).size.height / 3)
                      ],
                    )
                  : Column(
                      children: [
                        //**********APPBAR***********//
                        appBar,

                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: SizedBox(
                            height: 100,
                            width: 300,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColorDark,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Icon(
                                            Icons.email_outlined,
                                            color: Colors.grey,
                                          ),
                                          Text(
                                            user.email,
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          (user.enabled)
                                              ? const Icon(Icons.check,
                                                  color: Colors.greenAccent)
                                              : const Icon(Icons.close,
                                                  color: Colors.red),
                                          Text(
                                            (user.enabled)
                                                ? "Enabled"
                                                : "Disabled",
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        ButtonWidget(
                          text: "View User Profile",
                          function: () {},
                          color: "dark",
                        ),
                        (user.enabled)
                            ? ButtonWidget(
                                text: "Disable User",
                                function: () {},
                              )
                            : ButtonWidget(
                                text: "Enable User",
                                function: () {},
                              ),
                        ButtonWidget(
                          text: "Delete User",
                          function: () {},
                          color: "red",
                        ),
                      ],
                    );
            },
          ),
        ),
        bottomNavigationBar: AdminNavBarWidget(store: store),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, AdminUserManagePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(loading: state.wait.isWaiting);
}

// view model
class _ViewModel extends Vm {
  final bool loading;

  _ViewModel({
    required this.loading,
  }) : super(equals: [loading]); // implementinf hashcode;
}
