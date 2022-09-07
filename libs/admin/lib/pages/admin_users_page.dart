import 'package:admin/widgets/admin_appbar_user_actions_widget.dart';
import 'package:admin/widgets/admin_appbar_widget.dart';
import 'package:admin/widgets/admin_navbar_widget.dart';
import 'package:admin/widgets/quickview_cognito_user_widget.dart';
import 'package:admin/widgets/quickview_reported_user_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/admin/get_reported_reviews_action.dart';
import 'package:redux_comp/actions/admin/get_reported_users_action.dart';
import 'package:redux_comp/models/admin/cognito_user_model.dart';
import 'package:redux_comp/redux_comp.dart';

class AdminUsersPage extends StatelessWidget {
  final Store<AppState> store;
  const AdminUsersPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) {
              List<Widget> cognitoUsers = [];
              for (CognitoUserModel user in vm.cognitoUsers) {
                cognitoUsers.add(
                    QuickViewCognitoUserCardWidget(user: user, store: store));
              }
              return (vm.loading)
                  ? Column(
                      children: [
                        //**********APPBAR***********//
                        AdminAppBarWidget(
                            title: "User Management", store: store),
                        //*******************************************//

                        LoadingWidget(
                            padding: MediaQuery.of(context).size.height / 3)
                      ],
                    )
                  : Column(
                      children: [
                        //**********APPBAR***********//
                        AdminAppBarWidget(
                          title: "User Management",
                          store: store,
                          filterActions: AdminAppbarUserActionsWidget(
                            store: store,
                            functions: {
                              "List reported users": vm.pushUserReportsPage,
                              "List reported reviews": vm.pushReviewReportsPage
                            },
                          ),
                        ),

                        ...cognitoUsers
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
class _Factory extends VmFactory<AppState, AdminUsersPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        cognitoUsers: state.admin.activeCognitoUsers!,
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