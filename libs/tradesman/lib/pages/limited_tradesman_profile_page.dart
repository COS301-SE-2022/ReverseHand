import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:redux_comp/actions/admin/app_management/add_user_report_action.dart';
import 'package:redux_comp/models/admin/app_management/models/report_user_details_model.dart';
import 'package:redux_comp/models/admin/app_management/report_details_model.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:general/pages/report_page.dart';

class LimitedTradesmanProfilePage extends StatelessWidget {
  final Store<AppState> store;
  const LimitedTradesmanProfilePage({Key? key, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) {
              //*******************STAR CALC*********************//
              int startAmount = vm.userDetails.statistics.ratingSum == 0
                  ? 0
                  : vm.userDetails.statistics.ratingSum ~/
                      vm.userDetails.statistics.ratingCount;

              List<Icon> stars = [];

              for (int i = 0; i < startAmount; i++) {
                stars.add(Icon(Icons.star,
                    size: 30, color: Theme.of(context).primaryColor));
              }
              //*************************************************//

              return Column(
                children: [
                  //*******************APP BAR WIDGET*********************//
                  AppBarWidget(
                      title: "PROFILE", store: store, backButton: true),
                  //********************************************************//

                  //**************HEADING***************/
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Center(
                    child: Text(
                      vm.userDetails.name != null
                          ? vm.userDetails.name!
                          : "null",
                      style: const TextStyle(fontSize: 35),
                    ),
                  ),
                  //************************************/

                  //****************ICON****************/
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: vm.userDetails.profileImage == null
                        ? const AssetImage("assets/images/profile.png",
                            package: 'general')
                        : Image.network(vm.userDetails.profileImage!).image,
                  ),
                  //************************************/

                  //****************RATING**************/
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
                    child: SizedBox(
                      height: 70,
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                //if there is a rating - 1 is the lowest that can be given
                                //so not checking if rating is null
                                vm.userDetails.statistics.ratingCount != 0
                                    ? stars
                                    : [
                                        //if no rating yet
                                        const Text(
                                          "No rating yet",
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 18),
                                        )
                                      ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //************************************/

                  //************STATS*******************/
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    Text(
                                      "${vm.userDetails.statistics.finished} Jobs Completed",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.front_hand_outlined,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    Text(
                                      "${vm.userDetails.statistics.created} Bids Made",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  //ADD REVIEWS HERE

                  const Padding(padding: EdgeInsets.only(top: 15)),
                  TransparentLongButtonWidget(
                    text: "Report Contractor",
                    function: () {
                      //alternate way in view model
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReportPage(
                                  store: store,
                                  reportType: "User",
                                )),
                      );
                    },
                  )

                  //***********************************/
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: NavBarWidget(
          store: store,
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, LimitedTradesmanProfilePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        isWaiting: state.wait.isWaiting,
        userDetails: state.otherUserDetails,
        addUserReport: (report, user) =>
            dispatch(AddUserReportAction(report: report, user: user)),
        //this doesn't work at the moment
        pushReportPage: () {
          dispatch(NavigateAction.pushNamed('/general/report_page',
              arguments: ReportPage(
                store: widget!.store,
                reportType: "User",
              )));
        },
      );
}

// view model
class _ViewModel extends Vm {
  final UserModel userDetails;
  final VoidCallback pushReportPage;
  final void Function(ReportDetailsModel, ReportUserDetailsModel) addUserReport;
  final bool isWaiting;

  _ViewModel({
    required this.userDetails,
    required this.addUserReport,
    required this.isWaiting,
    required this.pushReportPage,
  }) : super(equals: [userDetails, isWaiting]);
}
