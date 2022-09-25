import 'package:admin/widgets/admin_navbar_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/appbar_popup_menu_widget.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:redux_comp/actions/admin/app_management/get_reported_adverts_action.dart';
import 'package:redux_comp/actions/admin/app_management/get_user_reports_action.dart';
import 'package:redux_comp/actions/admin/app_management/get_review_reports_action.dart';
import 'package:redux_comp/actions/admin/app_management/list_users_action.dart';
import 'package:redux_comp/redux_comp.dart';

class AdminManagePage extends StatelessWidget {
  final Store<AppState> store;
  const AdminManagePage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            Widget appbar = AppBarWidget(
              title: "Content Management",
              store: store,
              filterActions: AppbarPopUpMenuWidget(
                  store: store, functions: {"Search users": vm.pushSearchUsersPage}),
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

                      AdminContainerWidget(
                          text: "Advert Reports", function: () => vm.pushAdvertReportsPage()),
                      AdminContainerWidget(
                          text: "User Reports",
                          function: () => vm.pushUserReportsPage()),
                      AdminContainerWidget(
                          text: "Review Reports",
                          function: () => vm.pushReviewReportsPage()),
                    ],
                  );
          },
        ),
        bottomNavigationBar: AdminNavBarWidget(store: store),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, AdminManagePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        pushSearchUsersPage: () {
          dispatch(NavigateAction.pushNamed('/search_users'));
          dispatch(ListUsersAction("customer"));
          dispatch(ListUsersAction("tradesman"));
        },
        pushUserReportsPage: () {
          dispatch(NavigateAction.pushNamed('/user_reports_page'));
          dispatch(GetUserReportsAction());
        },
        pushReviewReportsPage: () {
          dispatch(NavigateAction.pushNamed('/review_reports_page'));
          dispatch(GetReviewReportsAction());
        },
        pushAdvertReportsPage: () {
           dispatch(NavigateAction.pushNamed('/advert_reports_page'));
          dispatch(GetReportedAdvertsAction());
        }
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final VoidCallback pushUserReportsPage;
  final VoidCallback pushReviewReportsPage;
  final VoidCallback pushAdvertReportsPage;
  final VoidCallback pushSearchUsersPage;

  _ViewModel({
    required this.loading,
    required this.pushUserReportsPage,
    required this.pushReviewReportsPage,
    required this.pushAdvertReportsPage,
    required this.pushSearchUsersPage,
  }) : super(equals: [loading]); // implementinf hashcode;
}

class AdminContainerWidget extends StatelessWidget {
  final String text;
  final void Function() function;

  const AdminContainerWidget(
      {super.key, required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4.5,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.circular(7)),
      child: Align(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "View all $text:",
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            LongButtonWidget(
              text: text,
              function: function,
            )
          ],
        ),
      ),
    );
  }
}
