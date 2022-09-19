import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/profile_divider.dart';
import 'package:redux_comp/actions/add_user_report_action.dart';
import 'package:redux_comp/models/admin/app_management/models/report_user_details_model.dart';
import 'package:redux_comp/models/admin/app_management/report_details_model.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
import 'package:redux_comp/redux_comp.dart';
import '../widgets/long_button_widget.dart';
import '../widgets/report_widgets/report_user_widget.dart';
import '../widgets/textfield.dart';

class ReportPage extends StatelessWidget {
  final Store<AppState> store;
  final String passedReason;

  ReportPage({
    Key? key,
    required this.store,
    required this.passedReason,
  }) : super(key: key);

  final descrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) => Column(
              children: [
                //*******************APP BAR***************//
                AppBarWidget(title: "REPORT", store: store, backButton: true),
                //*****************************************//

                const Padding(padding: EdgeInsets.only(top: 30)),

                //******************TEXT****************//
                const Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "1. Select a reason for this report:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const ProfileDividerWidget(),
                ReportUserSelectWidget(
                  store: store,
                ),
                //**************************************//

                const Padding(padding: EdgeInsets.only(top: 20)),

                //******************DESC****************//
                const Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "1. Provide a description for this report:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

                LongButtonWidget(
                    text: "Submit Review",
                    function: () {
                      ReportDetailsModel report = ReportDetailsModel(
                        description: descrController.value.text,
                        //no idea if the reason will actually be passed will have to test
                        reason: passedReason,
                        reportedUser: ReportUserDetailsModel(
                          id: vm.otherUser.id,
                          name: vm.otherUser.name ?? "nameNull",
                        ),
                      );
                      ReportUserDetailsModel user = ReportUserDetailsModel(
                          id: vm.userDetails.id, name: vm.userDetails.name!);
                      vm.addUserReport(report, user);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, ReportPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        otherUser: state.otherUserDetails,
        isWaiting: state.wait.isWaiting,
        userDetails: state.userDetails,
        addUserReport: (report, user) =>
            dispatch(AddUserReportAction(report: report, user: user)),
      );
}

// view model
class _ViewModel extends Vm {
  final UserModel userDetails;
  final UserModel otherUser;
  final void Function(ReportDetailsModel, ReportUserDetailsModel) addUserReport;
  final bool isWaiting;

  _ViewModel(
      {required this.userDetails,
      required this.otherUser,
      required this.addUserReport,
      required this.isWaiting})
      : super(equals: [userDetails, isWaiting]);
}
