import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:general/widgets/profile_image.dart';
import 'package:redux_comp/actions/user/user_table/edit_user_details_action.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/profile_divider.dart';
import 'package:redux_comp/actions/user/amplify_auth/logout_action.dart';
import 'package:general/widgets/bottom_sheet.dart';
import 'package:tradesman/widgets/reviews/review_widget.dart';
import '../widgets/multiselect_widget.dart';
import '../widgets/tradesman_navbar_widget.dart';

class TradesmanProfilePage extends StatefulWidget {
  final Store<AppState> store;

  const TradesmanProfilePage({Key? key, required this.store}) : super(key: key);

  @override
  State<TradesmanProfilePage> createState() => _TradesmanProfilePageState();
}

class _TradesmanProfilePageState extends State<TradesmanProfilePage> {
  final nameController = TextEditingController();
  final cellController = TextEditingController();

  List<String> selectedItems = [];

  void showMultiSelect(List<String> selected) async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectWidget(selectedItems: selected);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        selectedItems = results;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    cellController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) {
                if (vm.isWaiting) {
                  return Column(
                    children: [
                      AppBarWidget(title: "PROFILE", store: widget.store),
                      LoadingWidget(
                          topPadding: MediaQuery.of(context).size.height / 3,
                          bottomPadding: 0)
                    ],
                  );
                } else {
                  if (selectedItems.isNotEmpty &&
                      selectedItems != vm.userDetails.tradeTypes) {
                    vm.dispatchChangeTradeAction(
                        vm.userDetails.id, selectedItems);
                  }
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
                          width: MediaQuery.of(context).size.width / 1.7,
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
                      domains.add(
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0, bottom: 3),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColorLight,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(7))),
                            width: MediaQuery.of(context).size.width / 1.7,
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
                        ),
                      );
                    }
                  }

                  int startAmount = vm.userDetails.statistics.ratingSum == 0
                      ? 0
                      : vm.userDetails.statistics.ratingSum ~/
                          vm.userDetails.statistics.ratingCount;

                  List<Icon> stars = [];
                  for (int i = 0; i < startAmount; i++) {
                    stars.add(Icon(Icons.star,
                        size: 30, color: Theme.of(context).primaryColor));
                  }

                  return Column(children: [
                    //**************APPBAR***************/
                    AppBarWidget(store: widget.store, title: "PROFILE"),
                    //***********************************/

                    const Padding(padding: EdgeInsets.only(top: 20)),

                    //**************HEADING***************/
                    Center(
                      child: Text(
                        vm.userDetails.name != null
                            ? vm.userDetails.name!
                            : "null",
                        style: const TextStyle(fontSize: 35),
                      ),
                    ),
                    //************************************/

                    const Padding(padding: EdgeInsets.only(bottom: 10)),

                    //****************ICON****************/
                    ProfileImageWidget(
                      store: widget.store,
                    ),
                    //************************************/

                    //****************RATING**************/
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 25, 8, 8),
                      child: SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width / 1.15,
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
                                    text: "See my Reviews",
                                    function: () {
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20.0,
                                                            right: 8),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: const Icon(
                                                            Icons.close,
                                                            color: Colors.black,
                                                          )),
                                                    ),
                                                  ),
                                                  //****************************************//

                                                  //******************REVIEWS***************//
                                                  ReviewWidget(
                                                      store: widget.store),
                                                  ReviewWidget(
                                                      store: widget.store),
                                                  //****************************************//
                                                ],
                                              ),
                                            );
                                          });
                                    }),
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
                        width: MediaQuery.of(context).size.width / 1.15,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorDark,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.check_circle_outline,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Text(
                                        "${vm.userDetails.statistics.created} Jobs Completed",
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
                                        "${vm.userDetails.statistics.finished} Bids Made",
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
                                        controller: nameController,
                                        function: () {
                                          vm.dispatchChangeNameAction(
                                              vm.userDetails.id,
                                              nameController.value.text);
                                          Navigator.pop(context);
                                        },
                                      );
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

                    //************CELL*******************/
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
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
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white)),
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
                                              "What cell number would you like to save?",
                                          initialVal: vm.userDetails.cellNo,
                                          controller: nameController,
                                          function: () {
                                            vm.dispatchChangeCellAction(
                                                vm.userDetails.id,
                                                nameController.value.text);
                                            Navigator.pop(context);
                                          });
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
                                showMultiSelect(vm.userDetails.tradeTypes);
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
                              onPressed: vm.pushDomainConfirmPage,
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

                    //**********TEMP LOGOUT BUTTON********/
                    IconButton(
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      onPressed: vm.dispatchLogoutAction,
                      splashRadius: 30,
                      highlightColor: Colors.orange,
                      splashColor: Colors.white,
                    ),
                    //************************************/

                    const Padding(padding: EdgeInsets.only(bottom: 50)),
                  ]);
                }
              }),
        ),
        //****************NAVBAR****************/
        bottomNavigationBar: TNavBarWidget(
          store: widget.store,
        ),
        //**************************************/
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, _TradesmanProfilePageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        userDetails: state.userDetails,
        dispatchLogoutAction: () => dispatch(LogoutAction()),
        dispatchChangeNameAction: (String userId, String name) => dispatch(
            EditUserDetailsAction(userId: userId, changed: "name", name: name)),
        dispatchChangeCellAction: (String userId, String cellNo) => dispatch(
            EditUserDetailsAction(
                userId: userId, changed: "cellNo", cellNo: cellNo)),
        dispatchChangeTradeAction: (String userId, List<String> trades) =>
            dispatch(EditUserDetailsAction(
                userId: userId, changed: "tradetypes", tradeTypes: trades)),
        isWaiting: state.wait.isWaiting,
        pushDomainConfirmPage: () => dispatch(
          NavigateAction.pushNamed('/tradesman/domain_confirm'),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final UserModel userDetails;
  final VoidCallback pushDomainConfirmPage;
  final void Function() dispatchLogoutAction;
  final void Function(String, String) dispatchChangeNameAction;
  final void Function(String, String) dispatchChangeCellAction;
  final void Function(String, List<String>) dispatchChangeTradeAction;
  final bool isWaiting;

  _ViewModel({
    required this.userDetails,
    required this.pushDomainConfirmPage,
    required this.dispatchLogoutAction,
    required this.dispatchChangeNameAction,
    required this.dispatchChangeCellAction,
    required this.dispatchChangeTradeAction,
    required this.isWaiting,
  }) : super(equals: [userDetails, isWaiting]);
}
