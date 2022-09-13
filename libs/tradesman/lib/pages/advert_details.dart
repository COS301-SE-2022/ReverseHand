import 'package:async_redux/async_redux.dart';
import 'package:authentication/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:general/methods/time.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/image_carousel_widget.dart';
import 'package:general/widgets/job_card.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:tradesman/widgets/upload_bid_widgets/upload_quote_sheet.dart';
import '../widgets/quick_view_bid_widget.dart';
import '../widgets/tradesman_navbar_widget.dart';

class TradesmanJobDetails extends StatelessWidget {
  final Store<AppState> store;
  const TradesmanJobDetails({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final List<String> images = [
    //   "https://media.istockphoto.com/photos/mess-and-dump-an-old-room-with-lots-of-things-devastation-very-small-picture-id1189357377?k=20&m=1189357377&s=612x612&w=0&h=l2VJRihipV0DSRf2VImuCde4wloj4vkuJhylLWcybC8=",
    //   "https://www.researchgate.net/publication/264635711/figure/fig2/AS:213433816490008@1427897995893/Living-room-The-patients-living-room-was-filled-with-dirty-clothing-old-newspaper-and.png",
    //   "https://renegademothering.com/wp-content/uploads/2015/06/FullSizeRender-5.jpg",
    // ];

    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) =>
              SingleChildScrollView(
            child: Column(
              children: [
                //**********APPBAR***********//
                AppBarWidget(title: "JOB INFO", store: store),
                //*******************************************//

                //******************CAROUSEL ****************//
                // ImageCarouselWidget(images: images, store: store),
                //*******************************************//

                //**********DETAILED JOB INFORMATION***********//
                JobCardWidget(
                    titleText: vm.advert.title,
                    descText: vm.advert.description ?? "",
                    date: timestampToDate(vm.advert.dateCreated),
                    type: vm.advert.type,
                    location: vm.advert.domain.city,
                    store: store),

                const Padding(padding: EdgeInsets.only(top: 40)),

                //*************BOTTOM BUTTONS**************//
                vm.bids.contains(vm.currentBid)
                    //if this contractor has already made a bid
                    ? Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 45.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "My bid",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 42, right: 42, bottom: 50, top: 10),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 232, 232, 232),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0)),
                              ),
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Amount:',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'R${vm.currentBid.priceLower}  -  R${vm.currentBid.priceUpper}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(top: 10)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          'Quote:',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'None Uploaded',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    //if this contractor hasn't already made a bid
                    : Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: AuthButtonWidget(
                            text: "Place Bid",
                            function: () {
                              //keeping this here so that a bid can still be made while we create the last UI
                              // DarkDialogHelper.display(
                              //     context, PlaceBidPopupWidget(store: store), 1000.0);
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  builder: (BuildContext context) {
                                    return const UploadQuoteSheet();
                                  });
                            }),
                      ),
                //place bid

                TransparentLongButtonWidget(
                    text: "View Bids", function: vm.pushViewBidsPage),
                const Padding(padding: EdgeInsets.only(top: 20)),
                // TransparentLongButtonWidget(
                //     text: "Report this Advert", function: () {})
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
        currentBid: state.userBid!,
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;
  final AdvertModel advert;
  final List<BidModel> bids;
  final BidModel currentBid;
  final VoidCallback pushViewBidsPage;
  final VoidCallback pushEditAdvert;
  final VoidCallback pushConsumerListings;

  _ViewModel({
    required this.advert,
    required this.bids,
    required this.currentBid,
    required this.popPage,
    required this.pushEditAdvert,
    required this.pushViewBidsPage,
    required this.pushConsumerListings,
  }) : super(equals: [advert]);
}
