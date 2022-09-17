import 'package:admin/widgets/report_details_widget.dart';
import 'package:admin/widgets/report_user_descr_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/admin/app_management/admin_get_user_action.dart';
import 'package:redux_comp/actions/admin/app_management/get_review_reports_action.dart';
import 'package:redux_comp/actions/admin/app_management/remove_review_report_action.dart';
import 'package:redux_comp/models/admin/app_management/report_model.dart';
import 'package:redux_comp/redux_comp.dart';

class ReviewReportManagePage extends StatelessWidget {
  final Store<AppState> store;
  const ReviewReportManagePage({Key? key, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReportModel report =
        ModalRoute.of(context)!.settings.arguments as ReportModel;

    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            Widget appbar = AppBarWidget(
              title: "Manage Report",
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

                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Text(
                          report.type == "user#reports"
                              ? "User Report"
                              : "Review Report",
                          style: const TextStyle(fontSize: 25),
                        ),
                      ),

                      ReportDetailsWidget(
                        reason: report.reportDetails.reason,
                        description: report.reportDetails.description,
                      ),

                      ReportDetailsWidget(
                          reason: report.reviewDetails!.description,
                          description: report.reviewDetails!.rating.toString()),

                      ReportUserDescrWidget(
                        title: "Reported User",
                        name: report.reportDetails.reportedUser!.name,
                        function: () {
                          vm.dispatchGetUser(
                              report.reportDetails.reportedUser!.id);
                          vm.pushUserManagePage();
                        },
                      ),

                      ReportUserDescrWidget(
                        title: "Reporter User",
                        name: report.reportDetails.reporterUser.name,
                        function: () {
                          vm.dispatchGetUser(
                              report.reportDetails.reporterUser.id);
                          vm.pushUserManagePage();
                        },
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 25)),

                      ButtonWidget(
                        text: "Issue Warning",
                        function: () {
                          vm.dispatchRemoveWithWarning(
                            report.id,
                            report.reportDetails.reportedUser!.id,
                          );
                          vm.dispatchGetReviewReports();
                          vm.popPage();
                        },
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 25)),

                      ButtonWidget(
                        text: "Remove Report",
                        color: "dark",
                        function: () {
                          vm.dispatchRemoveWithoutWarning(
                            report.id,
                            report.reportDetails.reportedUser!.id,
                          );
                          vm.dispatchGetReviewReports();
                          vm.popPage();
                        },
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ReviewReportManagePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        dispatchGetReviewReports: () => dispatch(GetReviewReportsAction()),
        dispatchGetUser: (userId) => dispatch(AdminGetUserAction(userId)),
        pushUserManagePage: () =>
            dispatch(NavigateAction.pushNamed("/user_manage")),
        popPage: () => dispatch(NavigateAction.pop()),
        dispatchRemoveWithWarning: (reportId, userId) => dispatch(
            RemoveReviewReportAction(
                userId: userId, reportId: reportId, issueWarning: true)),
        dispatchRemoveWithoutWarning: (reportId, userId) => dispatch(
            RemoveReviewReportAction(
                userId: userId, reportId: reportId, issueWarning: false)),
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final void Function() dispatchGetReviewReports;
  final void Function(String) dispatchGetUser;
  final void Function(String, String) dispatchRemoveWithWarning;
  final void Function(String, String) dispatchRemoveWithoutWarning;
  final VoidCallback pushUserManagePage;
  final VoidCallback popPage;

  _ViewModel({
    required this.loading,
        required this.dispatchGetReviewReports,
    required this.dispatchGetUser,
    required this.dispatchRemoveWithWarning,
    required this.dispatchRemoveWithoutWarning,
    required this.pushUserManagePage,
    required this.popPage,
  }) : super(equals: [loading]); // implementinf hashcode;
}