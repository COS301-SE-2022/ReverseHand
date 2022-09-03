import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/profile_image.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/profile_divider.dart';
import 'package:redux_comp/actions/user/amplify_auth/logout_action.dart';
import 'package:general/widgets/bottom_sheet.dart';

import '../widgets/multiselect_widget.dart';
import '../widgets/tradesman_navbar_widget.dart';

class TradesmanProfilePage extends StatelessWidget {
  final Store<AppState> store;
  final nameController = TextEditingController();
  TradesmanProfilePage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) {
                List<Widget> trades = [];
                List<Widget> domains = [];
                for (var i = 0; i < vm.userDetails.tradeTypes.length; i++) {
                  {
                    trades.add(Padding(
                      padding: const EdgeInsets.only(top: 3.0, bottom: 3),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(7))),
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              vm.userDetails.tradeTypes.elementAt(i),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ));
                  }
                }
                for (var i = 0; i < vm.userDetails.domains.length; i++) {
                  {
                    domains.add(Padding(
                      padding: const EdgeInsets.only(top: 3.0, bottom: 3),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(7))),
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "${vm.userDetails.domains.elementAt(i).city}, ${vm.userDetails.domains.elementAt(i).province}",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ));
                  }
                }
                return Column(children: [
                  //**************APPBAR***************/
                  AppBarWidget(store: store, title: "PROFILE"),
                  //***********************************/

                  const Padding(padding: EdgeInsets.only(top: 20)),

                  //**************HEADING***************/
                  Center(
                    child: Text(
                      (vm.userDetails.name != null)
                          ? vm.userDetails.name!
                          : "null",
                      style: const TextStyle(fontSize: 35),
                    ),
                  ),
                  //************************************/

                  //****************ICON****************/
                  ProfileImageWidget(
                    store: store,
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
                                  size: 30,
                                  color: Theme.of(context).primaryColor),
                              Icon(Icons.star,
                                  size: 30,
                                  color: Theme.of(context).primaryColor),
                              Icon(Icons.star,
                                  size: 30,
                                  color: Theme.of(context).primaryColor),
                              Icon(Icons.star,
                                  size: 30,
                                  color: Theme.of(context).primaryColor),
                              Icon(Icons.star,
                                  size: 30,
                                  color: Theme.of(context).primaryColor),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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

                  //************EMAIL*******************/
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 40, right: 30, top: 20, bottom: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.email,
                          color: Colors.white70,
                          size: 26.0,
                        ),
                        const Padding(padding: EdgeInsets.only(right: 8)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: Text(vm.userDetails.email,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  //************************************/

                  const ProfileDividerWidget(),

                  //************NAME*******************/
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return BottomSheetWidget(
                                        text:
                                            "What name would you like to save?",
                                        initialVal: vm.userDetails.name,
                                        controller: nameController, function: () {  },);
                                  });
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 15,
                            )),
                      ],
                    ),
                  ),
                  //************************************/

                  const ProfileDividerWidget(),

                  //************TRADES******************/
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.construction,
                              color: Colors.white70,
                              size: 26.0,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 8)),
                            Column(
                              children: [...trades],
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return const MultiSelectWidget(
                                      items: [
                                        "Painting",
                                        "Tiler",
                                        "Carpenter",
                                        "Cleaner",
                                        "Designer",
                                        "Landscaper",
                                        "Electrician",
                                        "Plumbing",
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 15,
                            ))
                      ],
                    ),
                  ),
                  //************************************/
                  const ProfileDividerWidget(),

                  //************DOMAINS*****************/

                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white70,
                              size: 26.0,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 8)),
                            Column(
                              children: [...domains],
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return BottomSheetWidget(
                                        text:
                                            "What location would you like to save?",
                                        initialVal: "test",
                                        controller: nameController, function: () {  },);
                                  });
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 15,
                            ))
                      ],
                    ),
                  ),
                  //************************************/

                  const ProfileDividerWidget(),

                  //***************EDIT*****************/
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  IconButton(
                    onPressed: vm.pushEditProfilePage,
                    icon: const Icon(Icons.edit),
                    color: Colors.white70,
                  ),
                  //************************************/

                  //**********TEMP LOGOUT BUTTON********/
                  IconButton(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    onPressed: () => vm.dispatchLogoutAction(),
                    splashRadius: 30,
                    highlightColor: Colors.orange,
                    splashColor: Colors.white,
                  ),
                  //************************************/

                  const Padding(padding: EdgeInsets.only(bottom: 50)),
                ]);
              }),
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
      dispatchLogoutAction: () => dispatch(LogoutAction()),
      pushEditProfilePage: () => dispatch(
            NavigateAction.pushNamed('/tradesman/edit_profile_page'),
          ));
}

// view model
class _ViewModel extends Vm {
  final UserModel userDetails;
  final VoidCallback pushEditProfilePage;
  final void Function() dispatchLogoutAction;

  _ViewModel({
    required this.pushEditProfilePage,
    required this.userDetails,
    required this.dispatchLogoutAction,
  }) : super(equals: [userDetails]);
}
