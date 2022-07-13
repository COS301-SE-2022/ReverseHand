// import 'dart:html';

import 'package:async_redux/async_redux.dart';
// ignore: depend_on_referenced_packages
import 'package:consumer/methods/populate_bids.dart';
import 'package:general/theme.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/bottom_overlay.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/job_card.dart';
import 'package:redux_comp/actions/bids/toggle_view_bids_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:general/widgets/floating_button.dart';

class TradesmanViewBidsPage extends StatelessWidget {
  final Store<AppState> store;

  const TradesmanViewBidsPage({Key? key, required this.store}) : super(key: key);

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
        length: 2,
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

                  const Padding(padding: EdgeInsets.all(10)),

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
                    ],
                  ),
                  //*****************TABS***********************//
                  ...populateBids(vm.bids, store),

                  Expanded(
                    child: Stack(children: [
                      BottomOverlayWidget(
                          height: MediaQuery.of(context).size.height / 2),
                      TabBarView(
                        children: [
                          //**************TAB 1 INFO********************//
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(children: [
                              ButtonWidget(
                                  text: "Back",
                                  color: "light",
                                  whiteBorder: true,
                                  function: vm.popPage)
                            ]
                                //all bids should be populated here
                                ),
                          ),
                          //****************************************//

                          //*****************TAB 2 INFO******************//
                          Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(children: [
                              ButtonWidget(
                                  text: "Back",
                                  color: "light",
                                  whiteBorder: true,
                                  function: vm.popPage)
                            ]
                                //active bids should be populated here
                                ),
                          ),
                          //*****************TAB 2******************//
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
class _Factory extends VmFactory<AppState, TradesmanViewBidsPage> {
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
