import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/bids/set_active_bid_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/bid_model.dart';

//used in consumer and tradesman

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
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Material(
            elevation: 3,
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            child: InkWell(
              onTap: () => vm.dispatchSetActiveBid(bid),
              child: Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 232, 232, 232),
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        //***********IF BID IS SHORTLISTED********/
                        //then display a star
                        if (bid.shortlisted)
                          Row(
                            children: [
                              (Icon(
                                Icons.bookmark,
                                color: Theme.of(context).primaryColor,
                              )),
                              const Padding(padding: EdgeInsets.all(2))
                            ],
                          ),
                        //***************************************/

                        //***********CONTRACTOR NAME*************/
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                              child: Center(
                                child: Text(
                                  '${bid.name}',
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //***************************************/
                      ],
                    ),
                    //**************BID RANGE********************/
                    Text(
                      'R${bid.priceLower}-R${bid.priceUpper}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 22, color: Colors.black),
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
