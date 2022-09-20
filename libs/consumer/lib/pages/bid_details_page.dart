import 'package:async_redux/async_redux.dart';
import 'package:consumer/widgets/light_dialog_helper.dart';
import 'package:consumer/widgets/accept_bid_popup.dart';
import 'package:flutter/material.dart';
import 'package:general/methods/toast_success.dart';
import 'package:general/widgets/appbar.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:redux_comp/actions/bids/shortlist_bid_action.dart';
import 'package:redux_comp/actions/get_pdf_action.dart';
import 'package:redux_comp/actions/user/get_other_user_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:redux_comp/models/error_type_model.dart';

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
                AppBarWidget(
                    title: "BID DETAILS", store: store, backButton: true),
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
                        onPressed: vm.dispatchShortListBidAction,
                        icon: Icon(
                          vm.bid.shortlisted
                              ? Icons.bookmark
                              : Icons.bookmark_outline,
                          size: 40,
                          color: Theme.of(context).primaryColor,
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
                    //**************BID PRICE***************/
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
                        vm.bid.amount(),
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //**************************************/

                    //**************SEE QUOTE BUTTON***************/
                    //if quote is not uploaded
                    //todo, add if statement back here
                    // const Padding(padding: EdgeInsets.only(top: 40)),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: const [
                    //     Text(
                    //       "No quote has been\n uploaded yet.",
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(fontSize: 20, color: Colors.white54),
                    //     ),
                    //   ],
                    // ),
                    // const Padding(padding: EdgeInsets.only(top: 15)),
                    if (vm.bid.quote != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 50, top: 20),
                        child: LongButtonWidget(
                          text: "View Quote",
                          function: () {
                            vm.pushViewQuotePage();
                            vm.dispatchGetPdfAction();
                          },
                        ),
                      ),
                  ],
                ),

                //****************BOTTOM BUTTONS**************//

                const Padding(padding: EdgeInsets.only(top: 55)),
                Column(
                  children: [
                    StoreConnector<AppState, _ViewModel>(
                      vm: () => _Factory(this),
                      onDidChange: (context, store, vm) {
                        if (store.state.error == ErrorType.none) {
                          displayToastSuccess(
                              context!, "Bid Accepted"); //todo, fix
                        }
                      },
                      builder: (BuildContext context, _ViewModel vm) => Center(
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
                    ),
                    TransparentLongButtonWidget(
                      text: "View Contractor Profile",
                      function: vm.dispatchGetOtherUserAction,
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
        dispatchShortListBidAction: () => dispatch(ShortlistBidAction()),
        dispatchGetOtherUserAction: () =>
            dispatch(GetOtherUserAction(state.activeBid!.userId)),
        bid: state.activeBid!,
        popPage: () => dispatch(NavigateAction.pop()),
        change: state.change,
        pushViewQuotePage: () => dispatch(
          NavigateAction.pushNamed('/consumer/view_quote_page'),
        ),
        dispatchGetPdfAction: () => dispatch(GetPdfAction()),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;
  final BidModel bid;
  final VoidCallback dispatchShortListBidAction;
  final bool change;
  final VoidCallback dispatchGetOtherUserAction;
  final VoidCallback pushViewQuotePage;
  final VoidCallback dispatchGetPdfAction;

  _ViewModel({
    required this.dispatchShortListBidAction,
    required this.dispatchGetOtherUserAction,
    required this.bid,
    required this.dispatchGetPdfAction,
    required this.popPage,
    required this.change,
    required this.pushViewQuotePage,
  }) : super(equals: [change, bid]); // implementinf hashcode
}
