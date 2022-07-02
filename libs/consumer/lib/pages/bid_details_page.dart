import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/floating_button.dart';
import 'package:general/widgets/navbar.dart';
import 'package:redux_comp/actions/accept_bid_action.dart';
import 'package:redux_comp/actions/shortlist_bid_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:general/widgets/shortlist_accept_button.dart';
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
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) => Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(children: [
                    //**********APPBAR***********//
                    const AppBarWidget(title: "BID DETAILS"),
                    //***************************//

                    //************DATE***********//
                    Positioned(
                      top: 90,
                      left: 35,
                      child: Text('${vm.bid.name}',
                          style: const TextStyle(
                              fontSize: 33, color: Colors.white)),
                    ),
                    //***************************//

                    //**********NAME***********//
                    Positioned(
                      top: 95,
                      right: 35,
                      child: Text(vm.bid.dateCreated,
                          style: const TextStyle(
                              fontSize: 17, color: Colors.white70)),
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
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //name
                        // Text('${vm.bid.name}',
                        //     style: const TextStyle(
                        //         fontSize: 33, color: Colors.white)),

                        //keep for now - still testing if appBar stack works on other screens

                        const Padding(padding: EdgeInsets.all(15)),

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
                        ),

                        //need to get this info dynamically
                      ]),
                  //*************************************//

                  //****************BOTTOM BUTTONS**************//
                  const Padding(padding: EdgeInsets.all(15)),
                  Stack(alignment: Alignment.center, children: <Widget>[
                    BottomOverlayWidget(
                      height: MediaQuery.of(context).size.height / 2,
                    ),

                    //shortlist/accept
                    Positioned(
                      top: 20,
                      child: ShortlistAcceptButtonWidget(
                        shortBid: vm.bid.isShortlisted(),
                        onTap: () => vm.bid.isShortlisted()
                            ? vm.dispatchAcceptBidAction()
                            : vm.dispatchShortListBidAction(),
                      ),
                    ),

                    //Back
                    Positioned(
                        top: 80,
                        child: ButtonWidget(
                            text: "Back",
                            color: "light",
                            whiteBorder: true,
                            function: vm.popPage)),
                  ]),
                  //******************************************//
                ],
              ),
            ),
            //************************NAVBAR***********************/
            floatingActionButton: const FloatingButtonWidget(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,

            bottomNavigationBar: NavBarWidget(
              store: store,
            ),
            //*****************************************************/
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
