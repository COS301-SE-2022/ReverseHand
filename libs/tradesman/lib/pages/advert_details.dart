import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/bottom_overlay.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/dialog_helper.dart';
import 'package:general/widgets/job_card.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import '../widgets/navbar.dart';
import '../widgets/place_bid_popup.dart';
// import '../widgets/place_bid_popup.dart';

class TradesmanJobDetails extends StatelessWidget {
  final Store<AppState> store;
  const TradesmanJobDetails({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: Scaffold(
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
                    date: vm.advert.dateCreated,
                    type: vm.advert.type!,
                    location: vm.advert.location,
                  ),

                  const Padding(padding: EdgeInsets.only(top: 50)),

                  //*************BOTTOM BUTTONS**************//
                  Stack(alignment: Alignment.center, children: <Widget>[
                    BottomOverlayWidget(
                      height: MediaQuery.of(context).size.height / 2,
                    ),

                    //place bid
                    Positioned(
                        top: 35,
                        child: ButtonWidget(
                            text: "Place Bid", function: () {DialogHelper.display(context,PlaceBidPopupWidget(store: store));})),
                    //fix function call here
                    //DialogHelper.display(context,PlaceBidPopupWidget(store: store),)

                    //view bids
                    Positioned(
                        top: 95,
                        child: ButtonWidget(
                            text: "View Bids",
                            color: "light",
                            function: vm.pushViewBidsPage)),

                    //Back
                    Positioned(
                        top: 155,
                        child: ButtonWidget(
                            text: "Back",
                            color: "light",
                            border: "white",
                            function: vm.popPage))
                  ]),
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
  });
}
