import 'package:admin/widgets/admin_appbar_widget.dart';
import 'package:admin/widgets/quickview_reported_user_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/admin/reported_user_model.dart';


class AdminReportedReviewsPage extends StatelessWidget {
  final Store<AppState> store;
  const AdminReportedReviewsPage({Key? key, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) {
              List<Widget> reportedUsers = [];
              for (ReportedUserModel user in vm.reportedUsers) {
                reportedUsers.add(
                    QuickViewReportedUserCardWidget(user: user, store: store));
              }

              return (vm.loading)
                  ? Column(
                      children: [
                        //**********APPBAR***********//
                        AdminAppBarWidget(
                          title: "Review reports",
                          store: store,
                          backButton: true,
                        ),
                        //*******************************************//

                        LoadingWidget(
                            padding: MediaQuery.of(context).size.height / 3)
                      ],
                    )
                  : Column(
                      children: [
                        //**********APPBAR***********//
                        AdminAppBarWidget(
                          title: "Review Reports",
                          store: store,
                          backButton: true,
                        ),

                        ...reportedUsers
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, AdminReportedReviewsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        reportedUsers: state.admin.activeUsers ?? [],
        loading: state.wait.isWaiting,
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final List<ReportedUserModel> reportedUsers;

  _ViewModel({
    required this.loading,
    required this.reportedUsers,
  }) : super(equals: [loading, reportedUsers]); // implementinf hashcode;
}
