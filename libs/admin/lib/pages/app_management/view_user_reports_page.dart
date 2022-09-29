import 'package:admin/widgets/quickview_report_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/list_refresh_widget.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/admin/app_management/get_user_reports_action.dart';
import 'package:redux_comp/models/admin/app_management/report_model.dart';
import 'package:redux_comp/redux_comp.dart';

class ViewUserReportsPage extends StatelessWidget {
  final Store<AppState> store;

  const ViewUserReportsPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            List<Widget> reports = [];
            for (ReportModel report in vm.reports) {
              reports.add(QuickviewReportWidget(store: store, report: report));
            }
            Widget appbar = AppBarWidget(
              title: "User Reports",
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
                      (reports.isEmpty)
                          ? Padding(
                              padding: EdgeInsets.only(
                                  top: (MediaQuery.of(context).size.height) / 4,
                                  left: 40,
                                  right: 40),
                              child: (const Text(
                                "There are no reported users.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white70),
                              )),
                            )
                          : ListRefreshWidget(
                              widgets: reports,
                              refreshFunction: () =>
                                  vm.dispatchGetUserReports(),
                            )
                    ],
                  );
          },
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ViewUserReportsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        reports: state.admin.adminManage.userReports ?? [],
        dispatchGetUserReports: () => dispatch(GetUserReportsAction()),
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final List<ReportModel> reports;
  final void Function() dispatchGetUserReports;

  _ViewModel({
    required this.loading,
    required this.reports,
    required this.dispatchGetUserReports,
  }) : super(equals: [loading, reports]); // implementinf hashcode;
}
