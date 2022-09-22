import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/pages/report_page.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/appbar_popup_menu_widget.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:tradesman/widgets/tradesman_navbar_widget.dart';

class LimitedConsumerProfilePage extends StatelessWidget {
  final Store<AppState> store;
  const LimitedConsumerProfilePage({Key? key, required this.store})
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
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Center(
                    child: Text(
                      vm.userDetails.name != null ? vm.userDetails.name! : "",
                      style: const TextStyle(fontSize: 35),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 20)),
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
                                      "Total adverts closed: ${vm.userDetails.statistics.finished}",
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
                                      "Total adverts made: ${vm.userDetails.statistics.created}",
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

                  //***********************************/
                ]);
              }),
        ),
        bottomNavigationBar: TNavBarWidget(
          store: store,
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, LimitedConsumerProfilePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        userDetails: state.otherUserDetails,
        isWaiting: state.wait.isWaiting,
        pushReportPage: () {
          dispatch(NavigateAction.pushNamed('/general/report_page'));
        },
      );
}

// view model
class _ViewModel extends Vm {
  final UserModel userDetails;
  final VoidCallback pushReportPage;
  final bool isWaiting;

  _ViewModel({
    required this.userDetails,
    required this.isWaiting,
    required this.pushReportPage,
  }) : super(equals: [userDetails, isWaiting]);
}
