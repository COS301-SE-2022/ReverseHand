// import 'dart:html';

import 'package:async_redux/async_redux.dart';
import 'package:general/widgets/dialog_helper.dart';
import 'package:consumer/widgets/filter_popup.dart';
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

import '../methods/populate_bids.dart';

class ViewBidsPage extends StatelessWidget {
  final Store<AppState> store;

  const ViewBidsPage({Key? key, required this.store}) : super(key: key);

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
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: Scaffold(
          body: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) =>
                SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //**********APPBAR*************//
                  const AppBarWidget(title: "JOB INFO"),
                  //******************************//

                  //**********DETAILED JOB INFORMATION***********//
                  JobCardWidget(
                    titleText: vm.advert.title,
                    descText: vm.advert.description ?? "",
                    date: vm.advert.dateCreated,
                    location: vm.advert.location,
                  ),
                  //*******************************************//

                  const Padding(padding: EdgeInsets.all(10)),

                  // ...populateBids(vm.bids, store),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonWidget(
                          text: "Back",
                          color: "dark",
                          border: "white",
                          function: vm.popPage),
                      const Padding(padding: EdgeInsets.all(5)),
                      ButtonWidget(
                        text: "Filter",
                        color: "dark",
                        function: () {
                          DialogHelper.display(
                            context,
                            FilterPopUpWidget(
                              store: store,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  Stack(children: [
                    BottomOverlayWidget(
                        height: MediaQuery.of(context).size.height),
                    Container(
                      padding: const EdgeInsets.all(50),
                      child: Column(children: [
                        ...populateBids(vm.bids, store),
                        //********IF NO BIDS********************/
                        if (vm.bids.isEmpty)
                          const Center(
                            child: (Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                "No bids have\n been made yet",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white54),
                              ),
                            )),
                          ),
                        //**************************************/
                      ]),
                    ),
                  ]),
                ],
              ),
            ),
          ),

          //************************NAVBAR***********************/
          bottomNavigationBar: NavBarWidget(
            store: store,
          ),

          resizeToAvoidBottomInset: false,
          // floatingActionButton: const FloatingButtonWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          //*************************************************//
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
        bids: state.viewBids,
        advert: state.activeAd!,
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
  }) : super(equals: [change, bids]); // implementing hashcode
}
