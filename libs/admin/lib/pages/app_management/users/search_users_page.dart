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
            );
            Widget search = SearchWidget(
                store: store,
                searchFunction: (value, group) {
                  vm.dispatchSearchUser(value, group);
                });
            List<QuickViewUserCardWidget> customer = [];
            List<QuickViewUserCardWidget> tradesman = [];
            for (var user in vm.customers) {
              customer.add(QuickViewUserCardWidget(store: store, user: user));
            }
            for (var user in vm.tradesman) {
              tradesman.add(QuickViewUserCardWidget(store: store, user: user));
            }
            //for tabbed view
            // List<QuickViewUserCardWidget> clients = [];
            // List<QuickViewUserCardWidget> contractors = [];
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
                : DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        //**********APPBAR***********//
                        appbar,
                        search,
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: TabBar(
                            indicatorColor: Theme.of(context).primaryColor,
                            tabs: const [
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  "Client",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  "Contractor",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //all these comments are for if we want a tabbed view
                        // *******************TAB BAR LABELS***********************//

                        Expanded(
                            child: TabBarView(children: [
                          //display loading icon
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                //a message if no in progress jobs
                                if (customer.isEmpty)
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                            4,
                                        left: 40,
                                        right: 40),
                                    child: (const Text(
                                      "No customer user's found",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white70),
                                    )),
                                  ),
                                //else display in progress jobs
                                ListRefreshWidget(
                                    widgets: customer,
                                    refreshFunction: () =>
                                        vm.dispatchListUser("customer")),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 33))
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                if (tradesman.isEmpty)
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: (MediaQuery.of(context)
                                                .size
                                                .height) /
                                            4,
                                        left: 40,
                                        right: 40),
                                    child: (const Text(
                                      "No tradesman user's found",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white70),
                                    )),
                                  ),
                                ListRefreshWidget(
                                    widgets: tradesman,
                                    refreshFunction: () =>
                                        vm.dispatchListUser("tradesman")),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 33))
                              ],
                            ),
                          ),
                        ])),
                        // ********************************************************//
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
        customers: state.admin.adminManage.customers?.users ?? [],
        tradesman: state.admin.adminManage.tradesman?.users ?? [],
        currentUser: state.userDetails.userType.toLowerCase(),
        dispatchSearchUser: (value, group) =>
            dispatch(AdminSearchUserAction(email: value, group: group)),
        dispatchListUser: (group) => dispatch(ListUsersAction(group)),
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final List<CognitoUserModel> customers;
  final List<CognitoUserModel> tradesman;
  final String currentUser;
  final void Function(String, String) dispatchSearchUser;
  final void Function(String) dispatchListUser;

  _ViewModel({
    required this.loading,
    required this.customers,
    required this.tradesman,
    required this.currentUser,
    required this.dispatchSearchUser,
    required this.dispatchListUser,
  }) : super(equals: [loading, customers, tradesman]); // implementinf hashcode;
}
