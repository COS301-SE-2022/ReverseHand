import 'package:async_redux/async_redux.dart';
import 'package:consumer/widgets/light_dialog_helper.dart';
import 'package:consumer/widgets/shortlist_bid_popup.dart';
import 'package:flutter/material.dart';
import 'package:general/methods/time.dart';
import 'package:general/widgets/appbar.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:redux_comp/actions/bids/accept_bid_action.dart';
import 'package:redux_comp/actions/bids/shortlist_bid_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:general/widgets/bottom_overlay.dart';
import 'package:general/widgets/button.dart';

class BidDetailsPage extends StatelessWidget {
  final Store<AppState> store;

  const BidDetailsPage({Key? key, required this.store}) : super(key: key);

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
              children: [
                //************APPBAR**************************//
                AppBarWidget(title: "BID DETAILS", store: store),
                //********************************************//

                //************NAME AND ROW*******************//
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${vm.bid.name}',
                          style: const TextStyle(
                              fontSize: 33, color: Colors.white)),
                      Text(
                        timestampToDate(vm.bid.dateCreated),
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                //*******************************************//

                //**********DIVIDER***********//
                Divider(
                  height: 20,
                  thickness: 0.5,
                  indent: 15,
                  endIndent: 15,
                  color: Theme.of(context).primaryColorLight,
                ),
                //****************************//

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //**************BID RANGE***************/
                    const Padding(padding: EdgeInsets.all(15)),
                    const Center(
                      child: Text(
                        'Quoted price',
                        style: TextStyle(fontSize: 20, color: Colors.white70),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(3)),
                    Center(
                      child: Text(
                        'R${vm.bid.priceLower} - R${vm.bid.priceUpper}',
                        style: const TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //**************************************/

                    //**************SEE QUOTE BUTTON***************/
                    //if quote is not uploaded
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    Row(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 58.0),
                            child: Text(
                              "No quote has been\n uploaded yet.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white54),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                              onPressed: () {
                                vm.dispatchShortListBidAction();
                              },
                              icon: Icon(
                                vm.bid.isShortlisted()
                                    ? Icons.bookmark
                                    : Icons.bookmark_outline,
                                color: Theme.of(context).primaryColor,
                              )),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 15))
                  ],
                ),

                //****************BOTTOM BUTTONS**************//
                const Padding(padding: EdgeInsets.only(top: 5)),
                Stack(alignment: Alignment.center, children: <Widget>[
                  BottomOverlayWidget(
                    height: MediaQuery.of(context).size.height / 2,
                  ),

                  Positioned(
                    top: 20,
                    child: ButtonWidget(
                        text: "Accept Bid",
                        function: () {
                          LightDialogHelper.display(
                              context,
                              ShortlistPopUpWidget(
                                store: store,
                                shortlisted:
                                    vm.bid.isShortlisted() ? true : false,
                              ),
                              320.0);
                        }),
                  ),

                  //Back
                  Positioned(
                    top: 80,
                    child: ButtonWidget(
                      text: "Back",
                      color: "light",
                      border: "white",
                      function: vm.popPage,
                    ),
                  ),
                ]),
                //******************************************//
              ],
            ),
          ),
          //************************NAVBAR***********************/
          bottomNavigationBar: NavBarWidget(
            store: store,
          ),
          //*****************************************************/
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
        bid: state.activeBid!,
        popPage: () => dispatch(NavigateAction.pop()),
        change: state.change,
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;
  final BidModel bid;
  final VoidCallback dispatchAcceptBidAction;
  final VoidCallback dispatchShortListBidAction;
  final bool change;

  _ViewModel({
    required this.dispatchAcceptBidAction,
    required this.dispatchShortListBidAction,
    required this.bid,
    required this.popPage,
    required this.change,
  }) : super(equals: [change, bid]); // implementinf hashcode
}
