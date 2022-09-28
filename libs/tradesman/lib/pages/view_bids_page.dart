import 'package:async_redux/async_redux.dart';
import 'package:general/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/list_refresh_widget.dart';
import 'package:redux_comp/actions/bids/toggle_view_bids_action.dart';
import 'package:redux_comp/actions/bids/view_bids_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:tradesman/methods/populate_bids.dart';

import '../widgets/tradesman_navbar_widget.dart';

class TradesmanViewBidsPage extends StatelessWidget {
  final Store<AppState> store;

  const TradesmanViewBidsPage({Key? key, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) => Column(
            children: <Widget>[
              //**********APPBAR*************//
              AppBarWidget(title: "BIDS INFO", store: store, backButton: true),
              //******************************//

              const Padding(padding: EdgeInsets.all(10)),
              Container(
                padding: const EdgeInsets.all(8),
                child: ListRefreshWidget(
                  widgets: [
                    if (vm.bids.isNotEmpty)
                      ...populateBids(vm.userId, vm.bids, store),
                    //********IF NO BIDS********************/
                    if (vm.bids.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Text(
                          "No bids have\n been made yet",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.white54),
                        ),
                      ),
                    //**************************************/
                  ],
                  refreshFunction: vm.dispatchViewBidsAction,
                ),
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
        dispatchViewBidsAction: () => dispatch(ViewBidsAction(pushPage: false)),
        userId: state.userDetails.id,
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
  final VoidCallback dispatchViewBidsAction;

  _ViewModel({
    required this.dispatchToggleViewBidsAction,
    required this.change,
    required this.popPage,
    required this.bids,
    required this.userId,
    required this.dispatchViewBidsAction,
    required this.advert,
  }) : super(equals: [change, bids]);
}
