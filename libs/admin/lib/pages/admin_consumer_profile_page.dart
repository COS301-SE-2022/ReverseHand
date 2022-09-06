import 'package:admin/widgets/admin_navbar_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:redux_comp/models/admin/reported_user_model.dart';
import 'package:redux_comp/redux_comp.dart';

class AdminConsumerProfilePage extends StatelessWidget {
  final Store<AppState> store;
  const AdminConsumerProfilePage({Key? key, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: Scaffold(
          body: SingleChildScrollView(
            child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) => Column(
                children: [
                  //*******************APP BAR WIDGET*********************//
                  AppBarWidget(title: "Customer Profile", store: store),
                  //********************************************************//

                  const Padding(padding: EdgeInsets.only(top: 20)),

                  //**************HEADING***************/
                  Center(
                    child: Text(
                      vm.userDetails.name,
                      style: const TextStyle(fontSize: 35),
                    ),
                  ),
                  //************************************/

                  //****************ICON****************/
                  const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 80.0,
                  ),
                  //************************************/

                  //************STATS*******************/
                  //CHANGE ICONS
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                      width: 300,
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
                                    const Text(
                                      "Reported Adverts",
                                      style: TextStyle(fontSize: 18),
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
                                    const Text(
                                      "Reported Reviews",
                                      style: TextStyle(fontSize: 18),
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
                  //************************************/

                  //************EMAIL*******************/
                  Padding(
                    padding: const EdgeInsets.only(left: 100, top: 5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.email,
                          color: Colors.white70,
                          size: 26.0,
                        ),
                        const Padding(padding: EdgeInsets.only(right: 8)),
                        Text(vm.userDetails.email,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white)),
                      ],
                    ),
                  ),
                  //************************************/

                  const Padding(padding: EdgeInsets.only(top: 20)),

                  //************PHONE*******************/
                  Padding(
                    padding: const EdgeInsets.only(left: 100, top: 5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          color: Colors.white70,
                          size: 26.0,
                        ),
                        const Padding(padding: EdgeInsets.only(right: 8)),
                        Text(vm.userDetails.cellNo,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white)),
                      ],
                    ),
                  ),
                  //************************************/
                  const Padding(padding: EdgeInsets.only(top: 20)),

                  //*******************ADVERTS BUTTON********************//
                  ButtonWidget(
                    text: "Review Reported Adverts",
                    function: () =>
                        vm.dispatchGetReportedAdverts(vm.userDetails.id),
                  ),
                  //**************************************************//
                  const Padding(padding: EdgeInsets.only(top: 20)),

                  //*******************ADVERTS BUTTON********************//
                  ButtonWidget(
                    text: "Review Reported Reviews",
                    function: () {},
                  ),
                  //**************************************************//
                ],
              ),
            ),
          ),
          bottomNavigationBar: AdminNavBarWidget(store: store),
        ));
  }
}

class _Factory extends VmFactory<AppState, AdminConsumerProfilePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchGetReportedAdverts: (item) {},
        userDetails: state.admin.activeUser!,
      );
}

// view model
class _ViewModel extends Vm {
  final ReportedUserModel userDetails;
  final void Function(String) dispatchGetReportedAdverts;

  _ViewModel({
    required this.userDetails,
    required this.dispatchGetReportedAdverts,
  }) : super(equals: [userDetails]);
}
