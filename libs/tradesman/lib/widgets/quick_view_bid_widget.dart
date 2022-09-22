import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/bids/set_active_bid_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/bid_model.dart';

//******************************** */
//  bid view wdiegt (clickable)
//******************************** */

class TQuickViewBidWidget extends StatelessWidget {
  final BidModel bid;
  final Store<AppState> store;
  final bool archived;

  const TQuickViewBidWidget({
    Key? key,
    required this.store,
    this.archived = false,
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
                  //***********CONTRACTOR NAME*************/
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                        child: Center(
                          child: Text(
                            '${bid.name}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                
                  //***************************************/
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          bid.amount(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 22, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
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
class _Factory extends VmFactory<AppState, TQuickViewBidWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchSetActiveBid: (bid) => dispatch(SetActiveBidAction(bid)),
        pushBidDetailsPage: () => dispatch(NavigateAction.pushNamed(
            "/${state.userDetails.userType.toLowerCase()}/advert_details/bid_details")),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(BidModel) dispatchSetActiveBid;
  final VoidCallback pushBidDetailsPage;

  _ViewModel({
    required this.pushBidDetailsPage,
    required this.dispatchSetActiveBid,
  }); // implementinf hashcode
}
