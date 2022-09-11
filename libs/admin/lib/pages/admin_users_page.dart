import 'package:admin/widgets/admin_appbar_user_actions_widget.dart';
import 'package:admin/widgets/admin_appbar_widget.dart';
import 'package:admin/widgets/admin_navbar_widget.dart';
import 'package:admin/widgets/quickview_cognito_user_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/admin/get_reported_reviews_action.dart';
import 'package:redux_comp/actions/admin/get_reported_users_action.dart';
import 'package:redux_comp/models/admin/cognito_user_model.dart';
import 'package:redux_comp/redux_comp.dart';

class AdminUsersPage extends StatefulWidget {
  final Store<AppState> store;
  const AdminUsersPage({Key? key, required this.store}) : super(key: key);

  @override
  State<AdminUsersPage> createState() => _AdminUsersPageState();
}

class _AdminUsersPageState extends State<AdminUsersPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) {
              List<Widget> cognitoUsers = [];
              for (CognitoUserModel user in vm.cognitoUsers) {
                cognitoUsers.add(QuickViewCognitoUserCardWidget(
                    user: user, store: widget.store));
              }

              Widget appBar = AdminAppBarWidget(
                title: "User Management",
                store: widget.store,
                filterActions: AdminAppbarUserActionsWidget(
                  store: widget.store,
                  functions: {
                    "List reported users": vm.pushUserReportsPage,
                    "List reported reviews": vm.pushReviewReportsPage
                  },
                ),
              );
              return (vm.loading)
                  ? Column(
                      children: [
                        //**********APPBAR***********//
                        appBar,
                        //*******************************************//

                        LoadingWidget(
                            topPadding: MediaQuery.of(context).size.height / 3,bottomPadding: 0)
                      ],
                    )
                  : Column(
                      children: [
                        //**********APPBAR***********//
                        appBar,

                        TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            suffixIcon: (searchController.value.text != "")
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      searchController.clear();
                                      setState(() {});
                                    },
                                  )
                                : const Icon(
                                    Icons.clear,
                                    color: Colors.grey,
                                  ),
                            hintText: 'Search...',
                            hintStyle: const TextStyle(color: Colors.white),
                            border: InputBorder.none,
                            fillColor: Colors.white,
                          ),
                        ),

                        ...cognitoUsers
                      ],
                    );
            },
          ),
        ),
        bottomNavigationBar: AdminNavBarWidget(store: widget.store),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, _AdminUsersPageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        cognitoUsers: state.admin.activeCognitoUsers ?? [],
        pushUserReportsPage: () {
          dispatch(GetReportedUsersAction());
          dispatch(NavigateAction.pushNamed('/admin_reported_users'));
        },
        pushReviewReportsPage: () {
          dispatch(GetReportedReviewsAction());
          dispatch(NavigateAction.pushNamed('/admin_reported_reviews'));
        },
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final List<CognitoUserModel> cognitoUsers;
  final VoidCallback pushUserReportsPage;
  final VoidCallback pushReviewReportsPage;

  _ViewModel({
    required this.loading,
    required this.cognitoUsers,
    required this.pushUserReportsPage,
    required this.pushReviewReportsPage,
  }) : super(equals: [loading, cognitoUsers]); // implementinf hashcode;
}
