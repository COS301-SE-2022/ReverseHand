import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:general/widgets/profile_divider.dart';
import 'package:general/widgets/textfield.dart';
import 'package:redux_comp/actions/admin/app_management/add_advert_report_action.dart';
import 'package:redux_comp/actions/admin/app_management/add_user_report_action.dart';
import 'package:redux_comp/models/admin/app_management/models/report_user_details_model.dart';
import 'package:redux_comp/models/admin/app_management/report_details_model.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
import 'package:redux_comp/redux_comp.dart';
import '../widgets/appbar.dart';

class ReportPage extends StatefulWidget {
  final Store<AppState> store;
  final String? reportType;

  const ReportPage({Key? key, required this.store, this.reportType})
      : super(key: key);

  final List<String> items = const [
    'Disrespectful or offensive behaviour',
    'Threatening violence or physical harm',
    'Prejudice or discrimination',
    'Harrassment',
    'Not who they say they are',
  ];
  @override
  State<ReportPage> createState() => _RadioSelectWidgetState();
}

class _RadioSelectWidgetState extends State<ReportPage> {
  String? _type;
  final descrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //*******************APP BAR***************//
            AppBarWidget(
                title: "REPORT", store: widget.store, backButton: true),
            //*****************************************//

            const Padding(padding: EdgeInsets.only(top: 30)),

            //******************TEXT****************//
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "1. Select a reason for this report:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const ProfileDividerWidget(),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ListBody(
                children: widget.items
                    .map((tradeType) => ListTile(
                          title: Text(
                            tradeType,
                            style: const TextStyle(fontSize: 17.5),
                          ),
                          leading: Radio<String>(
                            value: tradeType,
                            groupValue: _type,
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.orange),
                            onChanged: (String? value) {
                              setState(() {
                                _type = value;
                              });
                            },
                          ),
                        ))
                    .toList(),
              ),
            ),

            //******************DESC****************//
            const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "2. Provide a description for this report:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const ProfileDividerWidget(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: TextFieldWidget(
                label: "",
                obscure: false,
                min: 3,
                controller: descrController,
                initialVal: null,
              ),
            ),

            //**************************************//
            //remove the labels later - there to test routes are correct
            StoreProvider(
              store: widget.store,
              child: StoreConnector<AppState, _ViewModel>(
                vm: () => _Factory(this),
                builder: (BuildContext context, _ViewModel vm) =>
                    //IF A USER IS BEING REPORTED
                    widget.reportType == "User"
                        ? LongButtonWidget(
                            text: "Submit Review - User",
                            function: () {
                              vm.popPage();

                              ReportDetailsModel report = ReportDetailsModel(
                                description: descrController.value.text,
                                reason: _type!,
                                reportedUser: ReportUserDetailsModel(
                                  id: vm.otherUser.id,
                                  name: vm.otherUser.name ?? "nameNull",
                                ),
                              );
                              ReportUserDetailsModel user =
                                  ReportUserDetailsModel(
                                      id: vm.userDetails.id,
                                      name: vm.userDetails.name!);
                              vm.dispatchAddUserReportAction(report, user);
                            },
                          )
                        //IF A REVIEW IS BEING REPORTED
                        : widget.reportType == "Review"
                            ? LongButtonWidget(
                                text: "Submit Review - Rev", function: () {})
                            //IF AN ADVERT IS BEING REPORTED
                            : LongButtonWidget(
                                text: "Submit Review - Adv",
                                function: () {
                                  vm.popPage();

                                  ReportDetailsModel report =
                                      ReportDetailsModel(
                                    description: descrController.value.text,
                                    reason: _type!,
                                    reporterUser: ReportUserDetailsModel(
                                      id: vm.userDetails.id,
                                      name: vm.otherUser.name ?? "nameNull",
                                    ),
                                  );

                                  vm.dispatchAddSdvertReportAction(
                                      vm.activeAd!.userId, report);
                                },
                              ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, _RadioSelectWidgetState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        otherUser: state.otherUserDetails,
        isWaiting: state.wait.isWaiting,
        userDetails: state.userDetails,
        dispatchAddUserReportAction: (report, user) =>
            dispatch(AddUserReportAction(report: report, user: user)),
        dispatchAddSdvertReportAction:
            (String userId, ReportDetailsModel report) =>
                dispatch(AddAdvertReportAction(userId: userId, report: report)),
        popPage: () => dispatch(NavigateAction.pop()),
        activeAd: state.activeAd
      );
}

// view model
class _ViewModel extends Vm {
  final UserModel userDetails;
  final UserModel otherUser;
  final void Function(ReportDetailsModel, ReportUserDetailsModel)
      dispatchAddUserReportAction;
  final void Function(String, ReportDetailsModel) dispatchAddSdvertReportAction;
  final bool isWaiting;
  final AdvertModel? activeAd;
  final VoidCallback popPage;

  _ViewModel({
    required this.userDetails,
    required this.activeAd,
    required this.otherUser,
    required this.dispatchAddUserReportAction,
    required this.dispatchAddSdvertReportAction,
    required this.isWaiting,
    required this.popPage,
  }) : super(equals: [userDetails, isWaiting]);
}
