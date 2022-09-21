import 'package:admin/widgets/drop_down_options_widget.dart';
import 'package:admin/widgets/quickview_user_widget.dart';
import 'package:admin/widgets/search_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/list_refresh_widget.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/admin/app_management/admin_search_user_action.dart';
import 'package:redux_comp/actions/admin/app_management/list_users_action.dart';
import 'package:redux_comp/models/admin/app_management/models/cognito_user_model.dart';
import 'package:redux_comp/redux_comp.dart';

class SearchUsersPage extends StatelessWidget {
  final Store<AppState> store;

  const SearchUsersPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            Widget appbar = AppBarWidget(
              title: "List Users",
              store: store,
              backButton: true,
              refreshAction: () => vm.dispatchListUser(vm.activeGroup),
            );
            Widget search = SearchWidget(
                store: store,
                searchFunction: (value, group) {
                  vm.dispatchSearchUser(value, group);
                });
            List<QuickViewUserCardWidget> userWidgets = [];
            for (var user in vm.users) {
              userWidgets
                  .add(QuickViewUserCardWidget(store: store, user: user));
            }
            return (vm.loading)
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        //**********APPBAR***********//
                        appbar,
                        //*******************************************//
                        search,

                        LoadingWidget(
                            topPadding: MediaQuery.of(context).size.height / 3,
                            bottomPadding: 0)
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        //**********APPBAR***********//
                        appbar,

                        search,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("//lowkey want a tabbed view//"),
                            DropDownOptionsWidget(
                                title: "Group",
                                functions: {
                                  "Client": () =>
                                      vm.dispatchListUser("customer"),
                                  "Contractor": () =>
                                      vm.dispatchListUser("tradesman"),
                                },
                                currentItem: (vm.activeGroup == "customer")
                                    ? "Client"
                                    : "Contractor"),
                          ],
                        ),

                        (userWidgets.isEmpty)
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top: (MediaQuery.of(context).size.height) /
                                        4,
                                    left: 40,
                                    right: 40),
                                child: (const Text(
                                  "No users found.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white70),
                                )),
                              )
                            : ListRefreshWidget(
                                widgets: userWidgets,
                                refreshFunction: () =>
                                    vm.dispatchListUser("customer"),
                              ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, SearchUsersPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        users: state.admin.adminManage.usersList?.users ?? [],
        activeGroup: state.admin.adminManage.usersList?.group ?? "customer",
        dispatchSearchUser: (value, group) =>
            dispatch(AdminSearchUserAction(email: value, group: group)),
        dispatchListUser: (group) => dispatch(ListUsersAction(group)),
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final List<CognitoUserModel> users;
  final String activeGroup;
  final void Function(String, String) dispatchSearchUser;
  final void Function(String) dispatchListUser;

  _ViewModel({
    required this.loading,
    required this.users,
    required this.activeGroup,
    required this.dispatchSearchUser,
    required this.dispatchListUser,
  }) : super(equals: [loading, users]); // implementinf hashcode;
}
