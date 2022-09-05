import 'package:async_redux/async_redux.dart';
import 'package:authentication/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:general/methods/time.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/bottom_overlay.dart';
import 'package:general/widgets/button.dart';

import 'package:general/widgets/job_card.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import '../widgets/tradesman_navbar_widget.dart';
// import '../widgets/place_bid_popup.dart';

class TradesmanJobDetails extends StatelessWidget {
  final Store<AppState> store;
  final TextEditingController bidController = TextEditingController();
  TradesmanJobDetails({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        // backgroundColor: Theme.of(context).primaryColorLight,
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) =>
              SingleChildScrollView(
            child: Column(
              children: [
                //**********APPBAR***********//
                AppBarWidget(title: "JOB INFO", store: store),
                //*******************************************//

                //**********DETAILED JOB INFORMATION***********//
                JobCardWidget(
                  titleText: vm.advert.title,
                  descText: vm.advert.description ?? "",
                  date: timestampToDate(vm.advert.dateCreated),
                  type: vm.advert.type ?? "",
                  location: vm.advert.domain.city,
                ),

                const Padding(padding: EdgeInsets.only(top: 80)),

                

                //*************BOTTOM BUTTONS**************//
                AuthButtonWidget(
                    text: "Place Bid",
                    function: () {
                      // DarkDialogHelper.display(context,
                      //PlaceBidPopupWidget(store: store), 1000.0);
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          // isScrollControlled: true,
                          builder: (BuildContext context) {
                            return Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    "Place Bid",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      "Add a detailed breakdown of materials and services.\n You can return to this step later.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black)),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      "Enter the final amount for your bid.\n This is a required step.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(60, 20, 60, 10),
                                  child: TextFormField(
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    controller: bidController,
                                    onTap: () {},
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        borderSide: const BorderSide(
                                          color: Colors.orange,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ButtonWidget(
                                          text: "Submit", function: () {}),
                                      const Padding(padding: EdgeInsets.all(3)),
                                      ButtonWidget(
                                          text: "Cancel",
                                          color: "light",
                                          border: "lightBlue",
                                          function: () {
                                            vm.popPage();
                                          })
                                    ],
                                  ),
                                )
                              ],
                            );
                          });
                    }),
                //place bid

                AuthButtonWidget(
                    text: "View Bids", function: vm.pushViewBidsPage),
                //*************BOTTOM BUTTONS**************//
                // ...populateBids(vm.us vm.bids)
              ],
            ),
          ),
        ),
        //************************NAVBAR***********************/
        bottomNavigationBar: TNavBarWidget(
          store: store,
        ),

        //*************************************************//
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, TradesmanJobDetails> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        advert: state.activeAd!,
        bids: state.bids + state.shortlistBids,
        popPage: () => dispatch(
          NavigateAction.pop(),
        ),
        pushViewBidsPage: () => dispatch(
          NavigateAction.pushNamed('/tradesman/view_bids_page'),
        ),
        pushEditAdvert: () => dispatch(
          NavigateAction.pushNamed('/tradesman/edit_bid_page'),
        ),
        pushConsumerListings: () => dispatch(
          NavigateAction.pushNamed('/tradesman'),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;
  final AdvertModel advert;
  final List<BidModel> bids;
  final VoidCallback pushViewBidsPage;
  final VoidCallback pushEditAdvert;
  final VoidCallback pushConsumerListings;

  _ViewModel({
    required this.advert,
    required this.bids,
    required this.popPage,
    required this.pushEditAdvert,
    required this.pushViewBidsPage,
    required this.pushConsumerListings,
  }) : super(equals: [advert]);
}
