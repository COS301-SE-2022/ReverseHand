import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/profile_divider.dart';

import '../widgets/tradesman_navbar_widget.dart';

class TradesmanProfilePage extends StatelessWidget {
  final Store<AppState> store;
  const TradesmanProfilePage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) => Column(children: [
              //**************APPBAR***************/
              AppBarWidget(store: store, title: "PROFILE"),
              //***********************************/

              //**************HEADING***************/
              Center(
                child: Text(
                  (vm.userDetails.name != null) ? vm.userDetails.name! : "null",
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

              //****************RATING**************/
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
                child: SizedBox(
                  height: 70,
                  width: 300,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star,
                              size: 30, color: Theme.of(context).primaryColor),
                          Icon(Icons.star,
                              size: 30, color: Theme.of(context).primaryColor),
                          Icon(Icons.star,
                              size: 30, color: Theme.of(context).primaryColor),
                          Icon(Icons.star,
                              size: 30, color: Theme.of(context).primaryColor),
                          Icon(Icons.star,
                              size: 30, color: Theme.of(context).primaryColor),
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
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const Text(
                                  "11 Jobs Completed",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.front_hand_outlined,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const Text(
                                  "19 Bids Made",
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
              //***********************************/

              //************NAME*******************/
              Padding(
                padding: const EdgeInsets.only(left: 100, top: 20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.white70,
                      size: 26.0,
                    ),
                    const Padding(padding: EdgeInsets.only(right: 8)),
                    Text(
                      (vm.userDetails.name != null)
                          ? vm.userDetails.name!
                          : "null",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              //************************************/

              const ProfileDividerWidget(),

              //************CELL*******************/
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
                    Text(
                        (vm.userDetails.cellNo != null)
                            ? vm.userDetails.cellNo!
                            : "null",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                ),
              ),
              //************************************/

              const ProfileDividerWidget(),

              //************EMAIl*******************/
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
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                ),
              ),
              //************************************/
              const ProfileDividerWidget(),

              //************TRADES******************/
              Padding(
                padding: const EdgeInsets.only(left: 100, top: 5),
                child: Row(
                  children: [
                    const Icon(
                      Icons.construction_outlined,
                      color: Colors.white70,
                      size: 26.0,
                    ),
                    const Padding(padding: EdgeInsets.only(right: 8)),
                    SizedBox(
                      width: 200,
                      height: 25,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: vm.userDetails.tradeTypes
                            .map(
                              (element) => Text("$element ",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              //************************************/
              const ProfileDividerWidget(),

              //************DOMAINS*****************/
              Padding(
                padding: const EdgeInsets.only(left: 100, top: 5),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white70,
                      size: 26.0,
                    ),
                    const Padding(padding: EdgeInsets.only(right: 8)),
                    SizedBox(
                      width: 200,
                      height: 25,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: vm.userDetails.domains
                            .map(
                              (domain) => Text("${domain.city} ",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              //************************************/

              const ProfileDividerWidget(),

              //***************EDIT*****************/
              IconButton(
                onPressed: vm.pushEditProfilePage,
                icon: const Icon(Icons.edit),
                color: Colors.white70,
              ),
              //************************************/
            ]),
          ),
        ),
        //****************NAVBAR****************/
        bottomNavigationBar: TNavBarWidget(
          store: store,
        ),
        //**************************************/
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, TradesmanProfilePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      userDetails: state.userDetails!,
      pushEditProfilePage: () => dispatch(
            NavigateAction.pushNamed('/tradesman/edit_profile_page'),
          ));
}

// view model
class _ViewModel extends Vm {
  final UserModel userDetails;
  final VoidCallback pushEditProfilePage;

  _ViewModel({
    required this.pushEditProfilePage,
    required this.userDetails,
  }) : super(equals: [userDetails]);
}
