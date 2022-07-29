import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';
import 'package:redux_comp/actions/bids/accept_bid_action.dart';
import 'package:redux_comp/actions/bids/shortlist_bid_action.dart';
import 'package:redux_comp/app_state.dart';

class ShortlistPopUpWidget extends StatelessWidget {
  final Store<AppState> store;
  final bool shortlisted;

  const ShortlistPopUpWidget({
    required this.store,
    required this.shortlisted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            child: Text(
              shortlisted == true
                  ? "Are you sure you want to accept this bid?\n\n All other bids will be discarded."
                  : "Are you sure you want to shortlist this bid?\n\n The relevant Contractor will be notified to send a detailed quote.",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black, fontSize: 22),
            ),
          ),
          StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(
                  text: shortlisted == true
                      ? "Accept"
                      : "Shortlist", //if already shortlisted, accept should be the description
                  function: () {
                    shortlisted
                        ? vm.dispatchAcceptBidAction()
                        : vm.dispatchShortListBidAction();
                    Navigator.pop(context);
                  },
                ),
                const Padding(padding: EdgeInsets.all(5)),
                ButtonWidget(
                  text: "Cancel",
                  function: () => Navigator.pop(context),
                  color: "light",
                  border: "lightBlue",
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ShortlistPopUpWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchShortListBidAction: () => dispatch(ShortlistBidAction()),
        dispatchAcceptBidAction: () => dispatch(AcceptBidAction()),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback dispatchShortListBidAction;
  final VoidCallback dispatchAcceptBidAction;

  _ViewModel({
    required this.dispatchShortListBidAction,
    required this.dispatchAcceptBidAction,
  }); // implementinf hashcode
}
