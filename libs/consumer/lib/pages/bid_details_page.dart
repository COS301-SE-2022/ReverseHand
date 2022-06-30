import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/appbar.dart';
import 'package:redux_comp/actions/accept_bid_action.dart';
import 'package:redux_comp/actions/shortlist_bid_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:general/widgets/bid_card.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //**********APPBAR***********//
                const AppBarWidget(title: "BID DETAILS"),
                //***************************//

                //******************INFO***************//
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0.0, horizontal: 35),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //name
                        Text('${vm.bid.name}',
                            style: const TextStyle(
                                fontSize: 33, color: Colors.white)),

                        const Padding(padding: EdgeInsets.all(20)),

                        //bid range
                        const Center(
                          child: Text(
                            'Quoted price',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white70),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(8)),
                        Center(
                          child: Text(
                            'R${vm.bid.priceLower} - R${vm.bid.priceUpper}',
                            style: const TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        const Padding(padding: EdgeInsets.all(40)),

                        //contact information
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 30,
                            ),
                            const Padding(padding: EdgeInsets.all(3)),
                            Column(
                              children: const [
                                Center(
                                  child: Text(
                                    'Contact Details',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white70),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'info@gmail.com',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ) //need to get this info dynamically
                      ]),
                ),
                //*************************************//

                //***********PADDING BETWEEN BACK BUTTON AND ACCEPT*******//
                const Padding(padding: EdgeInsets.all(10)),
                //********************************************************//

                //****************BUTTON TO SHORTLIST/ACCEPT**************//
                // ShortlistAcceptButtonWidget(
                //   shortBid: vm.bid.isShortlisted(),
                //   onTap: () => vm.bid.isShortlisted()
                //       ? vm.dispatchAcceptBidAction()
                //       : vm.dispatchShortListBidAction(),
                // ),
                //********************************************************//
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
        change: state.change,
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;
  final BidModel bid;
  final VoidCallback dispatchShortListBidAction;
  final VoidCallback dispatchAcceptBidAction;
  final bool change;

  _ViewModel({
    required this.dispatchAcceptBidAction,
    required this.dispatchShortListBidAction,
    required this.bid,
    required this.popPage,
    required this.change,
  }) : super(equals: [change]); // implementinf hashcode
}
