import 'package:admin/widgets/admin_navbar_widget.dart';
import 'package:admin/widgets/quickview_report_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/methods/time.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/job_card.dart';
import 'package:redux_comp/models/admin/advert_report_model.dart';
import 'package:redux_comp/models/admin/reported_advert_model.dart';
import 'package:redux_comp/redux_comp.dart';

class AdminAdvertDetailsPage extends StatelessWidget {
  final Store<AppState> store;
  const AdminAdvertDetailsPage({Key? key, required this.store})
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
              List<Widget> reports = [];
              for (AdvertReportModel report in vm.reports) {
                reports
                    .add(QuickviewReportWidget(report: report, store: store));
              }

              return Column(children: [
                //**********APPBAR***********//
                AppBarWidget(title: "JOB INFO", store: store),
                //*******************************************//

                //**********DETAILED JOB INFORMATION***********//
                JobCardWidget(
                  titleText: vm.activeAdvert.advert.title,
                  descText: vm.activeAdvert.advert.description ?? "",
                  location: vm.activeAdvert.advert.domain.city,
                  type: vm.activeAdvert.advert.type,
                  date: timestampToDate(vm.activeAdvert.advert.dateCreated),
                  store: store
                ),
                //*******************************************//

                //CODE FOR BUTTONS - COMMENTED OUT TILL IT CAN BE DISPLAYED
                //  Padding(
                //           padding: const EdgeInsets.all(15.0),
                //           child: Column(
                //             children: const [
                //               Align(
                //                   alignment: Alignment.centerLeft,
                //                   child: Text(
                //                     "Advert Details: ",
                //                     style: TextStyle(fontSize: 20),
                //                   )),
                //               Align(
                //                   alignment: Alignment.centerLeft,
                //                   child: Text(
                //                     "Report Count: ",
                //                     style: TextStyle(fontSize: 20),
                //                   )),
                //             ],
                //           ),
                //         ),

                //         //****************BUTTONS**************//
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.end,
                //           children: [
                //             AuthButtonWidget(
                //               function: () {
                //                 showModalBottomSheet(
                //                     context: context,
                //                     builder: (BuildContext context) {
                //                       return SizedBox(
                //                         height: 200,
                //                         child: Column(
                //                           children: [
                //                             const Padding(
                //                               padding: EdgeInsets.fromLTRB(
                //                                   10, 30, 10, 10),
                //                               child: Text(
                //                                 "Are you sure you want to\n issue a warning?",
                //                                 textAlign: TextAlign.center,
                //                                 style: TextStyle(
                //                                     fontWeight: FontWeight.w500,
                //                                     color: Colors.black,
                //                                     fontSize: 23),
                //                               ),
                //                             ),
                //                             Row(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.center,
                //                               children: [
                //                                 ButtonWidget(
                //                                     text: " Issue ",
                //                                     function: () {}),
                //                                 const Padding(
                //                                     padding: EdgeInsets.all(5)),
                //                                 ButtonWidget(
                //                                   text: "Cancel",
                //                                   color: "light",
                //                                   border: "lightBlue",
                //                                   function: () =>
                //                                       Navigator.pop(context),
                //                                 ),
                //                               ],
                //                             ),
                //                           ],
                //                         ),
                //                       );
                //                     });
                //               },
                //               text: 'Issue Warning',
                //             ),
                //             AuthButtonWidget(
                //               function: () {
                //                 showModalBottomSheet(
                //                     context: context,
                //                     builder: (BuildContext context) {
                //                       return SizedBox(
                //                         height: 200,
                //                         child: Column(
                //                           children: [
                //                             const Padding(
                //                               padding: EdgeInsets.fromLTRB(
                //                                   10, 30, 10, 10),
                //                               child: Text(
                //                                 "Are you sure you want to\n remove this report?",
                //                                 textAlign: TextAlign.center,
                //                                 style: TextStyle(
                //                                     fontWeight: FontWeight.w500,
                //                                     color: Colors.black,
                //                                     fontSize: 23),
                //                               ),
                //                             ),
                //                             Row(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.center,
                //                               children: [
                //                                 ButtonWidget(
                //                                     text: "Remove",
                //                                     function: () {}),
                //                                 const Padding(
                //                                     padding: EdgeInsets.all(5)),
                //                                 ButtonWidget(
                //                                   text: " Cancel ",
                //                                   color: "light",
                //                                   border: "lightBlue",
                //                                   function: () =>
                //                                       Navigator.pop(context),
                //                                 ),
                //                               ],
                //                             ),
                //                           ],
                //                         ),
                //                       );
                //                     });
                //               },
                //               text: 'Remove Report',
                //             ),
                //           ],
                //         ),
                //****************BUTTONS**************//

                ...reports
              ]);
            },
          ),
        ),
        bottomNavigationBar: AdminNavBarWidget(store: store),
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, AdminAdvertDetailsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        reports: state.admin.activeAdvert!.reports,
        activeAdvert: state.admin.activeAdvert!,
      );
}

// view model
class _ViewModel extends Vm {
  final List<AdvertReportModel> reports;
  final ReportedAdvertModel activeAdvert;

  _ViewModel({
    required this.reports,
    required this.activeAdvert,
  }) : super(equals: [reports, activeAdvert]);
}
