import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/bids/set_active_bid_action.dart';
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
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
          child: Material(
            elevation: 3,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: InkWell(
              onTap: () => vm.dispatchSetActiveBid(bid),
              child: Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        //***********IF BID IS SHORTLISTED********/
                        //then display a star
                        if (bid.isShortlisted())
                          Row(
                            children: [
                              (Icon(
                                Icons.star_border,
                                color: Theme.of(context).primaryColor,
                              )),
                              const Padding(padding: EdgeInsets.all(2))
                            ],
                          ),
                        //***************************************/

                        //***********CONTRACTOR NAME*************/
                        Text(
                          '${bid.name}',
                          style: const TextStyle(
                              fontSize: 22, color: Colors.white),
                        ),
                        //***************************************/
                      ],
                    ),
                    //**************BID RANGE********************/
                    Text(
                      'R${bid.priceLower}  -  R${bid.priceUpper}',
                      style: const TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    //***************************************/
                  ],
                ),
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
