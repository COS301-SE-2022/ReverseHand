import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/methods/time.dart';
import 'package:general/widgets/appbar.dart';
import 'package:redux_comp/actions/bids/accept_bid_action.dart';
import 'package:redux_comp/actions/bids/shortlist_bid_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:general/widgets/bottom_overlay.dart';
import 'package:general/widgets/button.dart';
import '../widgets/tradesman_navbar_widget.dart';

class TBidDetailsPage extends StatelessWidget {
  final Store<AppState> store;

  const TBidDetailsPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(this),
        builder: (BuildContext context, _ViewModel vm) => Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(children: [
                  //**********APPBAR***********//
                  AppBarWidget(title: "BID DETAILS", store: store),
                  //***************************//

                  //************DATE***********//
                  Positioned(
                    top: 90,
                    left: 35,
                    child: Text('${vm.bid.name}',
                        style:
                            const TextStyle(fontSize: 33, color: Colors.white)),
                  ),
                  //***************************//

                  //**********NAME***********//
                  Positioned(
                    top: 95,
                    right: 35,
                    child: Text(
                      timestampToDate(vm.bid.dateCreated),
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  //***************************//
                ]),

                //**********DIVIDER***********//
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Divider(
                    height: 20,
                    thickness: 0.5,
                    indent: 15,
                    endIndent: 15,
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                //****************************//

                //******************INFO***************//
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Padding(padding: EdgeInsets.all(15)),

                  //bid range
                  const Center(
                    child: Text(
                      'Quoted price',
                      style: TextStyle(fontSize: 20, color: Colors.white70),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  Center(
                    child: Text(
                      vm.bid.amount(),
                      style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  const Padding(padding: EdgeInsets.all(40)),
                ]),
                //*************************************//

                //****************BOTTOM BUTTONS**************//
                const Padding(padding: EdgeInsets.all(15)),
                Stack(alignment: Alignment.center, children: <Widget>[
                  BottomOverlayWidget(
                    height: MediaQuery.of(context).size.height / 2,
                  ),

                  Positioned(
                    top: 20,
                    right: 35,
                    child: IconButton(
                      onPressed: vm.pushEditBidsPage,
                      icon: const Icon(Icons.edit),
                      color: Colors.white70,
                    ),
                  ),

                  //Delete
                  Positioned(
                      top: 40,
                      child: ButtonWidget(
                          text: "Delete",
                          border: "White",
                          function: vm.popPage)),

                  //Back
                  Positioned(
                      top: 95,
                      child: ButtonWidget(
                          text: "Back",
                          color: "light",
                          border: "White",
                          function: vm.popPage)),
                ]),
                //******************************************//
              ],
            ),
          ),
          //************************NAVBAR***********************/

          bottomNavigationBar: TNavBarWidget(
            store: store,
          ),
          //*****************************************************/
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, TBidDetailsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchAcceptBidAction: () => dispatch(AcceptBidAction()),
        dispatchShortListBidAction: () => dispatch(ShortlistBidAction()),
        bid: state.activeBid!,
        popPage: () => dispatch(NavigateAction.pop()),
        change: state.change,
        pushEditBidsPage: () => dispatch(
          NavigateAction.pushNamed('/tradesman/edit_bid'),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;
  final BidModel bid;
  final VoidCallback dispatchShortListBidAction;
  final VoidCallback dispatchAcceptBidAction;
  final bool change;
  final void Function() pushEditBidsPage;

  _ViewModel({
    required this.dispatchAcceptBidAction,
    required this.dispatchShortListBidAction,
    required this.bid,
    required this.popPage,
    required this.change,
    required this.pushEditBidsPage,
  }) : super(equals: [change]);
}
