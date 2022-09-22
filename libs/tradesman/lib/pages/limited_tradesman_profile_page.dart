import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/appbar_popup_menu_widget.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:redux_comp/actions/admin/app_management/add_user_report_action.dart';
import 'package:redux_comp/actions/user/reviews/get_user_reviews_action.dart';
import 'package:redux_comp/models/admin/app_management/models/report_user_details_model.dart';
import 'package:redux_comp/models/admin/app_management/report_details_model.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:general/pages/report_page.dart';
import 'package:tradesman/widgets/reviews/review_widget.dart';

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

                return Column(children: [
                  //*******************APP BAR WIDGET*********************//
                  AppBarWidget(
                      title: "PROFILE",
                      store: store,
                      filterActions:
                          AppbarPopUpMenuWidget(store: store, functions: {
                        "Report User": () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReportPage(
                                      store: store,
                                      reportType: "User",
                                    )),
                          );
                          
                        }
                      }),
                      backButton: true),
                  //********************************************************//


                  //****************ICON****************/
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: vm.userDetails.profileImage == null
                        ? const AssetImage("assets/images/profile.png",
                            package: 'general')
                        : Image.network(vm.userDetails.profileImage!).image,
                  ),
                  //************************************/

                  //**************HEADING***************/
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Center(
                    child: Text(
                      vm.userDetails.name != null ? vm.userDetails.name! : "",
                      style: const TextStyle(fontSize: 35),
                    ),
                  ),
                  //************************************/

                  //****************RATING**************/
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
                    child: SizedBox(
                      height: 150,
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                        //if there is a rating - 1 is the lowest that can be given
                                        //so not checking if rating is null
                                        vm.userDetails.statistics.ratingCount !=
                                                0
                                            ? stars
                                            : [
                                                //if no rating yet
                                                const Text(
                                                  "No rating yet",
                                                  style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 18),
                                                )
                                              ]),
                                const Padding(
                                    padding: EdgeInsets.only(top: 20)),
                                TransparentLongButtonWidget(
                                  text: "See Reviews",
                                  function: () {
                                    vm.dispatchGetUserReviewsAction();

                                    List<ReviewWidget> reviews = vm
                                        .userDetails.reviews
                                        .map((r) => ReviewWidget(review: r, store: store))
                                        .toList();

                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ),
                                      builder: (BuildContext context) {
                                        return SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              //******************CLOSE*****************//
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20.0, right: 8),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(
                                                        Icons.close,
                                                        color: Colors.black,
                                                      )),
                                                ),
                                              ),

                                              //******************REVIEWS***************//
                                              ...reviews,
                                              //****************************************//
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            )),
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
                                      "Jobs Completed: ${vm.userDetails.statistics.finished}",
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
                                      "Bids Made: ${vm.userDetails.statistics.created}",
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
                ]);
              }),
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
        dispatchGetUserReviewsAction: () => dispatch(GetUserReviewsAction()),
      );
}

// view model
class _ViewModel extends Vm {
  final UserModel userDetails;
  final void Function(ReportDetailsModel, ReportUserDetailsModel) addUserReport;
  final VoidCallback dispatchGetUserReviewsAction;
  final bool isWaiting;

  _ViewModel({
    required this.userDetails,
    required this.addUserReport,
    required this.isWaiting,
    required this.dispatchGetUserReviewsAction,
  }) : super(equals: [userDetails, isWaiting]);
}
