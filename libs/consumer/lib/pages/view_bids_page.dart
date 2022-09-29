import 'package:async_redux/async_redux.dart';
import 'package:consumer/widgets/consumer_floating_button.dart';
import 'package:general/widgets/dark_dialog_helper.dart';
import 'package:consumer/widgets/filter_popup.dart';
import 'package:general/widgets/appbar.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/hint_widget.dart';
import 'package:general/widgets/list_refresh_widget.dart';
import 'package:redux_comp/actions/bids/view_bids_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:general/methods/populate_bids.dart';

class ViewBidsPage extends StatelessWidget {
  final Store<AppState> store;

  const ViewBidsPage({
    Key? key,
    required this.store,
  }) : super(key: key);

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
              AppBarWidget(title: "BIDS", store: store, backButton: true),
              //******************************//

              const HintWidget(
                text: "Click on a bid to see more detailed information",
                colour: Colors.white70,
                padding: 15,
              ),
              (vm.bids.isEmpty)
                  ? const Center(
                      child: (Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "No bids to\n display",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.white54),
                        ),
                      )),
                    )
                  : ListRefreshWidget(
                      widgets: populateBids(vm.bids, store),
                      refreshFunction: vm.dispatchViewBidsAction,
                    ),
            ],
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
        popPage: () => dispatch(NavigateAction.pop()),
        bids: state.viewBids,
        advert: state.activeAd!,
        loading: state.wait.isWaiting,
        dispatchViewBidsAction: () => dispatch(ViewBidsAction(pushPage: false)),
      );
}

// // view model
class _ViewModel extends Vm {
  final AdvertModel advert;
  final List<BidModel> bids;
  final VoidCallback popPage;
  final bool change;
  final bool loading;
  final VoidCallback dispatchViewBidsAction;

  _ViewModel({
    required this.change,
    required this.popPage,
    required this.bids,
    required this.advert,
    required this.loading,
    required this.dispatchViewBidsAction,
  }) : super(equals: [change, bids]); // implementing hashcode
}
