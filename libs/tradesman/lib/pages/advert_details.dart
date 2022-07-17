import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/bottom_overlay.dart';
import 'package:general/widgets/button.dart';
// import 'package:general/widgets/dialog_helper.dart';
// import 'package:general/widgets/divider.dart';
import 'package:general/widgets/floating_button.dart';
import 'package:general/widgets/job_card.dart';
import 'package:general/widgets/navbar.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:tradesman/methods/populate_bids.dart';
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
                  const AppBarWidget(title: "JOB INFO"),
                  //*******************************************//

                  //**********DETAILED JOB INFORMATION***********//
                  JobCardWidget(
                    titleText: vm.advert.title,
                    descText: vm.advert.description ?? "",
                    date: vm.advert.dateCreated,
                    // location: advert.location ?? "",
                  ),

                  const Padding(padding: EdgeInsets.only(top: 50)),

                  //**********HEADING***********//
                  const Text(
                    "Information",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),

                  //**********PADDING***********//
                  const Padding(padding: EdgeInsets.all(15)),

                  //**********Consumer Information***********//
                  Column(
                    children: const <Widget>[
                      Text(
                        "Client name: Luke Skywalker",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Client cellphone: +27 89 076 2347",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Client email: consumer@gmail.com",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 30)),

                  //*************BOTTOM BUTTONS**************//
                  Stack(alignment: Alignment.center, children: <Widget>[
                    BottomOverlayWidget(
                      height: MediaQuery.of(context).size.height / 2,
                    ),

                    //place bid
                    Positioned(
                        top: 15,
                        child: ButtonWidget(
                            text: "Place Bid", function: vm.pushViewBidsPage)),
                    //fix function call here
                    //DialogHelper.display(context,PlaceBidPopupWidget(store: store),)

                    //view bids
                    Positioned(
                        top: 75,
                        child: ButtonWidget(
                            text: "View Bids", function: vm.pushViewBidsPage)),

                    //Delete - currently just takes you back to Consumer Listings page
                    Positioned(
                        top: 135,
                        child: ButtonWidget(
                            text: "Delete",
                            color: "light",
                            function: vm.pushConsumerListings)),

                    //Back
                    Positioned(
                        top: 195,
                        child: ButtonWidget(
                            text: "Back",
                            color: "light",
                            border: "white",
                            function: vm.popPage))
                  ]),
                  //*************BOTTOM BUTTONS**************//
                  ...populateBids(vm.bids)
                ],
              ),
            ),
          ),
          //************************NAVBAR***********************/
          bottomNavigationBar: NavBarWidget(
            store: store,
          ),
          resizeToAvoidBottomInset: false,
          floatingActionButton: const FloatingButtonWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
        advert: state.user!.activeAd!,
        bids: state.user!.bids + state.user!.shortlistBids,
        popPage: () => dispatch(
          NavigateAction.pop(),
        ),
        pushViewBidsPage: () => dispatch(
          NavigateAction.pushNamed('/consumer/view_bids'),
        ),
        pushEditAdvert: () => dispatch(
          NavigateAction.pushNamed('/consumer/edit_advert_page'),
        ),
        pushConsumerListings: () => dispatch(
          NavigateAction.pushNamed('/consumer'),
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
  }); // implementinf hashcode
}
