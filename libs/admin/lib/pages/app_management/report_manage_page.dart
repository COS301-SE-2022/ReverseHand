import 'package:admin/widgets/report_details_widget.dart';
import 'package:admin/widgets/report_user_descr_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:redux_comp/actions/admin/app_management/admin_get_user_action.dart';
import 'package:redux_comp/actions/admin/app_management/remove_user_report_action.dart';
import 'package:redux_comp/models/admin/app_management/report_model.dart';
import 'package:redux_comp/redux_comp.dart';

class ReportManagePage extends StatelessWidget {
  final Store<AppState> store;
  const ReportManagePage({Key? key, required this.store}) : super(key: key);

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

                      (report.reviewDetails != null)
                          ? ReportDetailsWidget(
                              reason: report.reviewDetails!.description,
                              description:
                                  report.reviewDetails!.rating.toString())
                          : Container(),

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
                      const Padding(padding: EdgeInsets.only(bottom: 40)),

                      LongButtonWidget(text: "Issue Warning", function: () => vm.dispatchRemoveWithWarning(
                          report.id,
                          report.reportDetails.reportedUser!.id,
                        ),),

                      TransparentLongButtonWidget(
                          text: "Remove Report", function: ()  => vm.dispatchRemoveWithoutWarning(
                          report.id,
                          report.reportDetails.reportedUser!.id,
                        ),)
                    ],
                  );
          },
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ReportManagePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        dispatchGetUser: (userId) => dispatch(AdminGetUserAction(userId)),
        pushUserManagePage: () =>
            dispatch(NavigateAction.pushNamed("/user_manage")),
        dispatchRemoveWithWarning: (reportId, userId) => dispatch(
            RemoveUserReportAction(
                userId: userId, reportId: reportId, issueWarning: true)),
        dispatchRemoveWithoutWarning: (reportId, userId) => dispatch(
            RemoveUserReportAction(
                userId: userId, reportId: reportId, issueWarning: false)),
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final void Function(String) dispatchGetUser;
  final void Function(String, String) dispatchRemoveWithWarning;
  final void Function(String, String) dispatchRemoveWithoutWarning;
  final VoidCallback pushUserManagePage;

  _ViewModel({
    required this.loading,
    required this.dispatchGetUser,
    required this.dispatchRemoveWithWarning,
    required this.dispatchRemoveWithoutWarning,
    required this.pushUserManagePage,
  }) : super(equals: [loading]); // implementinf hashcode;
}
