import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/set_active_bid_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/bid_model.dart';

class QuickViewBidWidget extends StatelessWidget {
  final BidModel bid;
  final Store<AppState> store;

  const QuickViewBidWidget({
    Key? key,
    required this.store,
    required this.bid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(this),
        builder: (BuildContext context, _ViewModel vm) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: InkWell(
            onTap: () => vm.dispatchSetActiveBid(bid),
            child: Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromRGBO(255, 153, 0, 1), width: 2.0),
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Text(
                bid.id,
                style: const TextStyle(fontSize: 25, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, QuickViewBidWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchSetActiveBid: (bid) => dispatch(SetActiveBidAction(bid)),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(BidModel) dispatchSetActiveBid;

  _ViewModel({
    required this.dispatchSetActiveBid,
  }); // implementinf hashcode
}
