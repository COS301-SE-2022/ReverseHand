import 'package:async_redux/async_redux.dart';
import 'package:consumer/widgets/light_dialog_helper.dart';
import 'package:consumer/widgets/accept_bid_popup.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:redux_comp/actions/bids/accept_bid_action.dart';
import 'package:redux_comp/actions/bids/shortlist_bid_action.dart';
import 'package:redux_comp/actions/user/get_other_user_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:general/widgets/long_button_widget.dart';

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
                  padding: const EdgeInsets.only(right: 15, top: 30, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${vm.bid.name}',
                          style: const TextStyle(
                              fontSize: 33, color: Colors.white)),
                      //do we still want the date?
                      // Text(
                      //   timestampToDate(vm.bid.dateCreated),
                      //   style: const TextStyle(
                      //     fontSize: 17,
                      //     color: Colors.white70,
                      //   ),
                      // ),

                      IconButton(
                          onPressed: () {
                            vm.dispatchShortListBidAction();
                          },
                          icon: Icon(
                            vm.bid.shortlisted
                                ? Icons.bookmark
                                : Icons.bookmark_outline,
                            size: 40,
                            color: Theme.of(context).primaryColor,
                          )),
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
                    const Padding(padding: EdgeInsets.only(top: 40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "No quote has been\n uploaded yet.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.white54),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 15))
                  ],
                ),

                //****************BOTTOM BUTTONS**************//

                const Padding(padding: EdgeInsets.only(top: 55)),
                Column(
                  children: [
                    Center(
                      child: LongButtonWidget(
                          text: "Accept Bid",
                          function: () {
                            LightDialogHelper.display(
                                context,
                                AcceptPopUpWidget(
                                  store: store,
                                ),
                                320.0);
                          }),
                    ),
                    TransparentLongButtonWidget(
                      text: "View Contractor Profile",
                      function: () =>
                          vm.dispatchGetOtherUserAction(vm.bid.userId),
                    )
                  ],
                ),
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
        dispatchGetOtherUserAction: (String userId) =>
            dispatch(GetOtherUserAction(userId)),
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
  final void Function(String userId) dispatchGetOtherUserAction;

  _ViewModel({
    required this.dispatchAcceptBidAction,
    required this.dispatchShortListBidAction,
    required this.dispatchGetOtherUserAction,
    required this.bid,
    required this.popPage,
    required this.change,
  }) : super(equals: [change, bid]); // implementinf hashcode
}
