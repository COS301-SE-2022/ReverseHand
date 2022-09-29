import 'package:admin/widgets/report_details_widget.dart';
import 'package:admin/widgets/report_user_descr_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:general/widgets/long_button_widget.dart';
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
            List<Icon> stars = [];
            for (int i = 0; i < report.reviewDetails!.rating; i++) {
              stars.add(Icon(Icons.star,
                  size: 30, color: Theme.of(context).primaryColor));
            }
            Widget appbar = AppBarWidget(
              title: "Review Report",
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
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        //**********APPBAR***********//
                        appbar,

                        // Padding(
                        //   padding: const EdgeInsets.only(top: 25),
                        //   child: Text(
                        //     report.type == "user#reports"
                        //         ? "User Report"
                        //         : "Review Report",
                        //     style: const TextStyle(fontSize: 25),
                        //   ),
                        // ),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        const Text(
                          "Report:",
                          style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.underline),
                        ),
                        ReportDetailsWidget(
                          reason: report.reportDetails.reason,
                          description: report.reportDetails.description,
                        ),

                        const Padding(padding: EdgeInsets.only(top: 30)),
                        const Text(
                          "Reported review:",
                          style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.underline),
                        ),

                        // ReportDetailsWidget(
                        //     reason: report.reviewDetails!.description,
                        //     description:
                        //         report.reviewDetails!.rating.toString()),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(7)),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 2)),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: stars

                                    //*****************STARS*****************//
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       left: 8.0, top: 5),
                                    //   child: Icon(
                                    //     Icons.star,
                                    //     color: Theme.of(context).primaryColor,
                                    //   ),
                                    // ),
                                    //***************************************//

                                    ),
                                const Padding(padding: EdgeInsets.only(top: 8)),
                                //******************MESSAGE*****************//
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 0, 10, 10),
                                    child: Text(
                                      report.reviewDetails!.description,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                //***************************************//
                              ],
                            ),
                          ),
                        ),

                        // ReportDetailsWidget(
                        //     reason: report.reviewDetails!.description,
                        //     description:
                        //         report.reviewDetails!.rating.toString()),

                        ReportUserDescrWidget(
                          title: "Reporter User",
                          name: report.reportDetails.reporterUser!.name,
                          function: () {
                            vm.dispatchGetUser(
                                report.reportDetails.reporterUser!.id);
                            vm.pushUserManagePage();
                          },
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 25)),

                        LongButtonWidget(
                          text: "Issue Warning",
                          function: () {
                            vm.dispatchRemoveWithWarning(
                              report.id,
                              report.userId!,
                            );
                          },
                        ),

                        TransparentLongButtonWidget(
                          text: "Remove Report",
                          function: () {
                            vm.dispatchRemoveWithoutWarning(
                              report.id,
                              report.userId!,
                            );
                          },
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20))
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
class _Factory extends VmFactory<AppState, ReviewReportManagePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        dispatchGetReviewReports: () => dispatch(GetReviewReportsAction()),
        dispatchGetUser: (userId) => dispatch(AdminGetUserAction(userId)),
        pushUserManagePage: () =>
            dispatch(NavigateAction.pushNamed("/user_manage", arguments: null)),
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
