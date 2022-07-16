// import 'dart:html';

import 'package:async_redux/async_redux.dart';
import 'package:general/theme.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/bottom_overlay.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/job_card.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:redux_comp/actions/bids/toggle_view_bids_action.dart';
import 'package:general/widgets/floating_button.dart';

import '../methods/populate_bids.dart';

class ViewBidsPage extends StatelessWidget {
  final Store<AppState> store;
  final List<String> _dropdownValues1 = [
    "Any",
    "Price: Low to High", //think about this wording
    "Price: High to Low",
  ];

  ViewBidsPage({Key? key, required this.store}) : super(key: key);

  @override

  //**********TABS TO FILTER ACTIVE/SHORTLISTED BIDS***********//
  // Row(
  //   mainAxisAlignment: MainAxisAlignment.center,
  //   children: [
  //     TabWidget(
  //       text: "ACTIVE",
  //       onPressed: (activate) =>
  //           vm.dispatchToggleViewBidsAction(false, activate),
  //     ),
  //     const Padding(padding: EdgeInsets.all(5)),
  //     TabWidget(
  //       text: "SHORTLIST",
  //       onPressed: (activate) =>
  //           vm.dispatchToggleViewBidsAction(true, activate),
  //     ),
  //   ],
  // ),
  //***********************************************************//

  //^^^keep this to integrate toggle

  // creating bid widgets
  // ...populateBids(vm.bids, store)

  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: DefaultTabController(
        length: 3,
        child: MaterialApp(
          theme: CustomTheme.darkTheme,
          home: Scaffold(
            body: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) => Column(
                children: <Widget>[
                  //**********APPBAR*************//
                  const AppBarWidget(title: "JOB INFO"),
                  //******************************//

                  //**********DETAILED JOB INFORMATION***********//
                  JobCardWidget(
                    titleText: vm.advert.title,
                    descText: vm.advert.description ?? "",
                    date: vm.advert.dateCreated,
                    // location: advert.location ?? "",
                  ),
                  //*******************************************//

                  // const Padding(padding: EdgeInsets.all(10)),

                  //*****************TABS***********************//
                  const TabBar(
                    isScrollable: true,
                    indicatorColor: Color.fromRGBO(243, 157, 55, 1),
                    indicatorWeight: 5,
                    labelColor: Colors.white, //selected text color
                    unselectedLabelColor: Colors.grey, //Unselected text
                    tabs: [
                      Tab(
                          child: Text(
                        'All',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )),
                      Tab(
                          child: Text(
                        'Shortlisted',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )),
                      Tab(child: Icon(Icons.filter_alt)),
                    ],
                  ),
                  //*****************TABS***********************//
                  // ...populateBids(vm.bids, store),

                  Expanded(
                    child: Stack(children: [
                      BottomOverlayWidget(
                          height: MediaQuery.of(context).size.height),
                      TabBarView(
                        children: [
                          //**************TAB 1 INFO********************//
                          SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(children: [
                                ...populateBids(vm.bids, store),
                                ButtonWidget(
                                    text: "Back",
                                    color: "light",
                                    border: "white",
                                    function: vm.popPage)
                              ]
                                  //all bids should be populated here
                                  ),
                            ),
                          ),
                          //****************************************//

                          //*****************TAB 2 INFO******************//
                          SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(children: [
                                ButtonWidget(
                                    text: "Back",
                                    color: "light",
                                    border: "white",
                                    function: vm.popPage)
                              ]
                                  //active bids should be populated here
                                  ),
                            ),
                          ),
                          //*****************TAB 2******************//

                          //*****************TAB 3 INFO******************//
                          SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(children: [
                                //***************SORT BY******************//
                                //text
                                const Padding(
                                  padding: EdgeInsets.only(left: 45, top: 10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Sort By",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 10)),
                                //dropdown container
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    borderRadius: BorderRadius.circular(
                                        20.0), //borderRadius for container
                                    border: Border.all(
                                        color: Colors.white,
                                        style: BorderStyle.solid,
                                        width: 1),
                                  ),
                                  //actual dropdown
                                  child: DropdownButton(
                                      dropdownColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(
                                          20.0), //borderRadius for dropdownMenu
                                      isExpanded: true,
                                      underline: const SizedBox.shrink(),
                                      value: _dropdownValues1.first,
                                      icon: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                        ),
                                      ),
                                      items: _dropdownValues1
                                          .map((value) => DropdownMenuItem(
                                                value: value,
                                                child: Text(value),
                                              ))
                                          .toList(),
                                      onChanged: ((_) {})),
                                ),
                                //******************************************//

                                //*****************PRICE RANGE******************//
                                //text
                                const Padding(
                                  padding: EdgeInsets.only(left: 45, top: 10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Price Range",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 10)),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //MINIMUM TEXTFIELD
                                    Container(
                                        height: 40,
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                    1.7) /
                                                2,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(
                                              20.0), //borderRadius for container
                                        ),
                                        child: TextFormField(
                                          // initialValue: "0",
                                          style: const TextStyle(
                                              color: Colors.white),
                                          controller: null,
                                          decoration: InputDecoration(
                                            labelText: "min",
                                            labelStyle: const TextStyle(
                                                color: Colors.white),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 1.0,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                color: Colors.orange,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                        )),

                                    //PADDING AND "-"
                                    const Padding(padding: EdgeInsets.all(5)),

                                    const Text(
                                      "-",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    ),
                                    const Padding(padding: EdgeInsets.all(5)),

                                    //MAXIMUM TEXTFIELD
                                    Container(
                                        height: 40,
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                    1.7) /
                                                2,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          borderRadius: BorderRadius.circular(
                                              20.0), //borderRadius for container
                                        ),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              color: Colors.white),
                                          controller: null,
                                          decoration: InputDecoration(
                                            labelText: "max",
                                            labelStyle: const TextStyle(
                                                color: Colors.white),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.auto,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 1.0,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                color: Colors.orange,
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                                //*******************************************//

                                const Padding(padding: EdgeInsets.all(10)),

                                //Buttons
                                ButtonWidget(
                                    text: "Apply",
                                    function:
                                        vm.popPage //need a different function
                                    ),

                                const Padding(padding: EdgeInsets.all(20))
                              ]),
                            ),
                          ),
                          //*****************TAB 3******************//
                        ],
                      ),
                    ]),
                  ),
                ],
              ),
            ),

            //************************NAVBAR***********************/
            bottomNavigationBar: NavBarWidget(
              store: store,
            ),

            resizeToAvoidBottomInset: false,
            floatingActionButton: const FloatingButtonWidget(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            //*************************************************//
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ViewBidsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        change: state.change,
        dispatchToggleViewBidsAction: (toggleShort, activate) =>
            dispatch(ToggleViewBidsAction(toggleShort, activate)),
        popPage: () => dispatch(NavigateAction.pop()),
        bids: state.user!.viewBids,
        advert: state.user!.activeAd!,
      );
}

// // view model
class _ViewModel extends Vm {
  final AdvertModel advert;
  final List<BidModel> bids;
  final VoidCallback popPage;
  final bool change;
  final void Function(bool, bool) dispatchToggleViewBidsAction;

  _ViewModel({
    required this.dispatchToggleViewBidsAction,
    required this.change,
    required this.popPage,
    required this.bids,
    required this.advert,
  }) : super(equals: [change]); // implementing hashcode
}
