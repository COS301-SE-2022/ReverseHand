import 'package:async_redux/async_redux.dart';
import 'package:general/theme.dart';
import 'package:general/widgets/tab.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/job_card.dart';
import 'package:redux_comp/app_state.dart';
import 'package:general/widgets/divider.dart';
import 'package:general/widgets/quick_view_bid.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:redux_comp/actions/toggle_view_bids_action.dart';

import '../methods/populate_adverts.dart';

class AdvertDetailsPage extends StatelessWidget {
  final Store<AppState> store;

  const AdvertDetailsPage({Key? key, required this.store}) : super(key: key);

  @override
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
                children: [
                  //**********PADDING FROM TOP*****************//
                  const Padding(padding: EdgeInsets.fromLTRB(10, 15, 10, 0)),
                  //*******************************************//

                  //**********BACK BUTTON*********************//
                  BackButton(
                    color: Colors.white,
                    onPressed: () => vm.popPage(),
                  ),
                  //*******************************************//

                  //**********DETAILED JOB INFORMATION***********//
                  JobCardWidget(
                    titleText: vm.advert.title,
                    descText: vm.advert.description ?? "",
                    date: vm.advert.dateCreated,
                    // location: advert.location ?? "",
                  ),
                  //*******************************************//

                  //**********DIVIDER**************************//
                  const DividerWidget(),
                  //*******************************************//

                  //**********HEADING**************************//
                  const Text(
                    "BIDS",
                    style: TextStyle(fontSize: 25.0, color: Colors.white),
                  ),
                  //*******************************************//

                  //**********PADDING**************************//
                  const Padding(padding: EdgeInsets.all(15)),
                  //*******************************************//

                  //**********TABS TO FILTER ACTIVE/SHORTLISTED BIDS***********//
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TabWidget(
                        text: "ACTIVE",
                        onPressed: (activate) =>
                            vm.dispatchToggleViewBidsAction(false, activate),
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      TabWidget(
                        text: "SHORTLIST",
                        onPressed: (activate) =>
                            vm.dispatchToggleViewBidsAction(true, activate),
                      ),
                    ],
                  ),
                  //***********************************************************//

                  // creating bid widgets
                  ...populateBids(vm.bids, store)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, AdvertDetailsPage> {
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

// view model
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
