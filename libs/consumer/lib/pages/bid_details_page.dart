import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:redux_comp/actions/accept_bid_action.dart';
import 'package:redux_comp/actions/shortlist_bid_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:general/widgets/card.dart';
import 'package:general/widgets/shortlist_accept_button.dart';
import 'package:redux_comp/models/bid_model.dart';

class BidDetailsPage extends StatelessWidget {
  final Store<AppState> store;

  const BidDetailsPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) => Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(
              children: <Widget>[
                //*******************PADDING FROM TOP*********************//
                const Padding(padding: EdgeInsets.fromLTRB(10, 15, 10, 0)),
                //********************************************************//

                //**********************BACK BUTTON**********************//
                BackButton(
                  color: Colors.white,
                  onPressed: () => vm.popPage,
                ),

                //********************************************************//

                //***********************CARD*****************************//
                CardWidget(
                  titleText: "MR J SMITH",
                  price1: vm.bid.priceLower,
                  price2: vm.bid.priceUpper,
                  details: "info@gmail.com",
                  quote: false,
                ),
                //********************************************************//

                //***********PADDING BETWEEN CARD AND BUTTON*************//
                const Padding(padding: EdgeInsets.all(10)),

                //****************BUTTON TO SHORTLIST/ACCEPT**************//
                ShortlistAcceptButtonWidget(
                  shortBid: vm.bid.isShortlisted(),
                  onTap: () => vm.bid.isShortlisted()
                      ? vm.dispatchAcceptBidAction()
                      : vm.dispatchShortListBidAction(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, BidDetailsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchAcceptBidAction: () => dispatch(AcceptBidAction()),
        dispatchShortListBidAction: () => dispatch(ShortlistBidAction()),
        bid: state.user!.activeBid!,
        popPage: () => dispatch(NavigateAction.pop()),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;
  final BidModel bid;
  final VoidCallback dispatchShortListBidAction;
  final VoidCallback dispatchAcceptBidAction;

  _ViewModel({
    required this.dispatchAcceptBidAction,
    required this.dispatchShortListBidAction,
    required this.bid,
    required this.popPage,
  }); // implementinf hashcode
}
