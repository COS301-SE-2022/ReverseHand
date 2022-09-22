import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:redux_comp/actions/get_pdf_action.dart';
import 'package:redux_comp/actions/user/get_other_user_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:general/widgets/long_button_widget.dart';

class ArchivedBidDetailsPage extends StatelessWidget {
  final Store<AppState> store;

  const ArchivedBidDetailsPage({Key? key, required this.store})
      : super(key: key);

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
                  padding: const EdgeInsets.only(right: 15, top: 30, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${vm.bid.name}',
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
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

                //****************BOTTOM BUTTON**************//
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 55),
                  child: TransparentLongButtonWidget(
                    text: "View Contractor Profile",
                    function: vm.dispatchGetOtherUserAction,
                  ),
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
class _Factory extends VmFactory<AppState, ArchivedBidDetailsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
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
  final bool change;
  final VoidCallback dispatchGetOtherUserAction;
  final VoidCallback pushViewQuotePage;
  final VoidCallback dispatchGetPdfAction;

  _ViewModel({
    required this.dispatchGetOtherUserAction,
    required this.bid,
    required this.dispatchGetPdfAction,
    required this.popPage,
    required this.change,
    required this.pushViewQuotePage,
  }) : super(equals: [change, bid]); // implementinf hashcode
}
