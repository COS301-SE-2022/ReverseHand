import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:general/widgets/profile_image.dart';
import 'package:redux_comp/models/user_models/statistics_model.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:consumer/widgets/consumer_navbar.dart';

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
                int startAmount = vm.userStatistics.ratingSum == 0
                    ? 0
                    : vm.userStatistics.ratingSum ~/
                        vm.userStatistics.ratingCount;

                List<Icon> stars = [];
                for (int i = 0; i < startAmount; i++) {
                  stars.add(Icon(Icons.star,
                      size: 30, color: Theme.of(context).primaryColor));
                }
                //*************************************************//

                return Column(children: [
                  //*******************APP BAR WIDGET*********************//
                  AppBarWidget(title: "JOB LISTINGS", store: store),
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
                  ProfileImageWidget(
                    store: store,
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
                            children: stars,
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
                                      "${vm.userStatistics.created} Jobs Completed",
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
                                      "${vm.userStatistics.finished} Bids Made",
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
                      text: "Report Contractor", function: () {})

                  //***********************************/
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
        userDetails: state.userDetails!,
        isWaiting: state.wait.isWaiting,
        userStatistics: state.userDetails!.statistics,
      );
}

// view model
class _ViewModel extends Vm {
  final UserModel userDetails;
  final bool isWaiting;
  final StatisticsModel userStatistics;

  _ViewModel({
    required this.userDetails,
    required this.isWaiting,
    required this.userStatistics,
  }) : super(equals: [userDetails, isWaiting, userStatistics]);
}