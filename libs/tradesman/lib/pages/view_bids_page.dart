// import 'dart:html';

import 'package:async_redux/async_redux.dart';
// ignore: depend_on_referenced_packages
import 'package:general/theme.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/bottom_overlay.dart';
import 'package:general/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/job_card.dart';
import 'package:redux_comp/actions/bids/toggle_view_bids_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:tradesman/methods/populate_bids.dart';

import '../widgets/navbar.dart';

class TradesmanViewBidsPage extends StatelessWidget {
  final Store<AppState> store;

  const TradesmanViewBidsPage({Key? key, required this.store})
      : super(key: key);

  @override

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
                    location: vm.advert.location,
                  ),
                  //*******************************************//

                  const Padding(padding: EdgeInsets.all(10)),

                  Expanded(
                    child: Stack(children: [
                      BottomOverlayWidget(
                          height: MediaQuery.of(context).size.height / 2),
                      //**************BID INFO********************//
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(children: [
                          ...populateBids(vm.userId, vm.bids),
                          ButtonWidget(
                              text: "Back",
                              color: "light",
                              whiteBorder: true,
                              function: vm.popPage)
                        ]
                            //all bids should be populated here
                            ),
                      ),
                      //****************************************/
                    ]),
                  ),
                ],
              ),
            ),

            //************************NAVBAR***********************/
            bottomNavigationBar: TNavBarWidget(
              store: store,
            ),

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
        bids: state.viewBids,
        advert: state.activeAd!,
        userId: state.userDetails!.id,
      );
}

// // view model
class _ViewModel extends Vm {
  final AdvertModel advert;
  final List<BidModel> bids;
  final String userId;
  final VoidCallback popPage;
  final bool change;
  final void Function(bool, bool) dispatchToggleViewBidsAction;

  _ViewModel({
    required this.dispatchToggleViewBidsAction,
    required this.change,
    required this.popPage,
    required this.bids,
    required this.userId,
    required this.advert,
  }) : super(equals: [change]);
}

/*

  "domains" : [
     {
      city : "Pretoria",
      coords : {
        lat : 20,
        lng: 10
      },
     {
      city : "Pretoria",
      coords : {
        lat : 20,
        lng: 10
      },
     {
      city : "Pretoria",
      coords : {
        lat : 20,
        lng: 10
      },

  ]






*/