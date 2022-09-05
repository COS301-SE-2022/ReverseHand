// import 'dart:html';

import 'package:async_redux/async_redux.dart';
import 'package:consumer/widgets/consumer_floating_button.dart';
import 'package:general/methods/time.dart';
import 'package:general/widgets/dark_dialog_helper.dart';
import 'package:consumer/widgets/filter_popup.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';

import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/job_card.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:redux_comp/actions/bids/toggle_view_bids_action.dart';

import '../methods/populate_bids.dart';

class ViewBidsPage extends StatelessWidget {
  final Store<AppState> store;

  const ViewBidsPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) =>
              SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //**********APPBAR*************//
                AppBarWidget(title: "JOB INFO", store: store),
                //******************************//

                //**********DETAILED JOB INFORMATION***********//
                JobCardWidget(
                  titleText: vm.advert.title,
                  descText: vm.advert.description ?? "",
                  date: timestampToDate(vm.advert.dateCreated),
                  type: vm.advert.type!,
                  location: vm.advert.domain.city,
                ),
                //*******************************************//

                const Padding(padding: EdgeInsets.all(10)),

                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(children: [
                    if (vm.bids.isNotEmpty)
                      const Divider(
                        color: Colors.white,
                        thickness: 0.5,
                        indent: 30,
                        endIndent: 30,
                      ),
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    ...populateBids(vm.bids, store),
                    //********IF NO BIDS********************/
                    if (vm.bids.isEmpty)
                      const Center(
                        child: (Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "No bids to\n display",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 20, color: Colors.white54),
                          ),
                        )),
                      ),
                    //**************************************/
                  ]),
                ),
              ],
            ),
          ),
        ),

        //************************NAVBAR***********************/
        floatingActionButton: ConsumerFloatingButtonWidget(
          function: () {
            DarkDialogHelper.display(
                context,
                FilterPopUpWidget(
                  store: store,
                ),
                600.0);
          },
          type: "filter",
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: NavBarWidget(
          store: store,
        ),
        //*************************************************//
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
        loading: state.wait.isWaiting,
      );
}

// // view model
class _ViewModel extends Vm {
  final AdvertModel advert;
  final List<BidModel> bids;
  final VoidCallback popPage;
  final bool change;
  final void Function(bool, bool) dispatchToggleViewBidsAction;
  final bool loading;

  _ViewModel({
    required this.dispatchToggleViewBidsAction,
    required this.change,
    required this.popPage,
    required this.bids,
    required this.advert,
    required this.loading,
  }) : super(equals: [change, bids]); // implementing hashcode
}
