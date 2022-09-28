import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/methods/toast_success.dart';
import 'package:general/widgets/button.dart';
import 'package:redux_comp/actions/bids/accept_bid_action.dart';
import 'package:redux_comp/actions/process_payment_action.dart';
import 'package:redux_comp/app_state.dart';

class AcceptPopUpWidget extends StatelessWidget {
  final Store<AppState> store;

  const AcceptPopUpWidget({
    required this.store,
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
            child: const Text(
              "Are you sure you want to accept this bid?\n\n All other bids will be discarded and payment will have to be made.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 22),
            ),
          ),
          StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(
                  text: "Accept",
                  function: () {
                    Navigator.pop(context);
                    // vm.dispatchAcceptBidAction();
                    vm.dispatchProcessPayementAction(context);
                    // displayToastSuccess(context, "Bid Accepted!");
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
class _Factory extends VmFactory<AppState, AcceptPopUpWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchAcceptBidAction: () => dispatch(AcceptBidAction()),
        dispatchProcessPayementAction: (BuildContext context) =>
            dispatch(ProcessPaymentAction(context)),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback dispatchAcceptBidAction;
  final void Function(BuildContext context) dispatchProcessPayementAction;

  _ViewModel({
    required this.dispatchAcceptBidAction,
    required this.dispatchProcessPayementAction,
  }); // implementinf hashcode
}
