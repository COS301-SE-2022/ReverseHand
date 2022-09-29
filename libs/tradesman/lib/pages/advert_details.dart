import 'dart:io';
import 'package:async_redux/async_redux.dart';
import 'package:general/pages/report_page.dart';
import 'package:general/widgets/appbar_popup_menu_widget.dart';
import 'package:general/widgets/user_bid_details_widget.dart';
import 'package:general/widgets/hint_widget.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:general/methods/time.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/image_carousel_widget.dart';
import 'package:general/widgets/job_card.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/analytics_events/record_place_bid_action.dart';
import 'package:redux_comp/actions/bids/place_bid_action.dart';
import 'package:redux_comp/actions/user/get_other_user_action.dart';
import 'package:redux_comp/actions/user/open_in_maps_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:tradesman/widgets/upload_bid_widgets/edit_bid_sheet.dart';
import 'package:tradesman/widgets/upload_bid_widgets/upload_quote_sheet.dart';
import '../widgets/tradesman_navbar_widget.dart';

class TradesmanJobDetails extends StatelessWidget {
  final Store<AppState> store;
  final TextEditingController bidPriceController = TextEditingController();
  TradesmanJobDetails({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    //**********APPBAR***********//
                    AppBarWidget(
                      title: "JOB INFO",
                      store: store,
                      filterActions: AppbarPopUpMenuWidget(
                        store: store,
                        functions: {
                          "Report Advert": () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReportPage(
                                  store: store,
                                  reportType: "Advert",
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      backButton: true,
                    ),
                    //*******************************************//

                    //******************CAROUSEL ****************//
                    if (vm.advert.images.isNotEmpty)
                      ImageCarouselWidget(images: vm.advert.images),
                    //*******************************************//

                    //**********DETAILED JOB INFORMATION***********//
                    if (vm.loading)
                      const LoadingWidget(topPadding: 80, bottomPadding: 0)
                    else
                      JobCardWidget(
                        titleText: vm.advert.title,
                        descText: vm.advert.description ?? "",
                        date: timestampToDate(vm.advert.dateCreated),
                        type: vm.advert.type,
                        location: vm.advert.domain.city,
                      ),

                    //*************BOTTOM BUTTONS**************//
                    vm.userBid != null
                        //if this contractor has already made a bid
                        ? Column(
                            children: [
                              //*************USER BID**************//
                              if ((vm.userBid != null &&
                                      vm.userBid!.shortlisted) ||
                                  !vm.accepted)
                                const Padding(
                                  padding: EdgeInsets.only(left: 45.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: HintWidget(
                                      text: "Click on your bid to edit it",
                                      colour: Colors.white70,
                                      padding: 0,
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 40,
                                  right: 40,
                                  bottom: 30,
                                  top: 10,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    if (vm.userBid != null &&
                                        vm.userBid!.shortlisted) return;
                                    if (vm.accepted) return;
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                      ),
                                      builder: (BuildContext context) {
                                        return EditBidSheet(
                                          store: store,
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 232, 232, 232),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7.0)),
                                    ),
                                    child: UserBidDetailsWidget(
                                      amount: vm.userBid!.amount(),
                                      quote: vm.userBid!.quote != null,
                                      status: vm.advert.acceptedBid != null
                                          ? 'Accepted'
                                          : vm.userBid!.shortlisted
                                              ? 'Favourited'
                                              : 'Pending',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        //***********************************//

                        //if this contractor hasn't already made a bid
                        : Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: LongButtonWidget(
                              text: "Place Bid",
                              function: () async {
                                final items = await showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  builder: (BuildContext context) {
                                    return const UploadQuoteSheet();
                                  },
                                );

                                if (items['price'] != null) {
                                  vm.dispatchPlaceBidAction(
                                    price: items['price'],
                                    quote: items['quote'],
                                  );

                                  vm.dispatchRecordPlaceBidAction(
                                    vm.advert.type,
                                    items['price'],
                                  );
                                }
                              },
                            ),
                          ),

                    //place bid
                    if (!vm.accepted)
                      TransparentLongButtonWidget(
                        text: "View Bids (${vm.bidCount})",
                        function: vm.pushViewBidsPage,
                      ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    TransparentLongButtonWidget(
                      text: "View Client Profile",
                      function: vm.dispatchGetOtherUserAction,
                    ),
                    if (vm.accepted) ...[
                      const Padding(padding: EdgeInsets.only(top: 35)),
                      TransparentLongButtonWidget(
                        text: "View Client Location",
                        function: () {
                          vm.dispatchOpenInMapsAction(context);
                        },
                      ),
                    ],
                  ],
                ),
              );
            }),
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
        bidCount: state.bids.length + state.shortlistBids.length,
        popPage: () => dispatch(
          NavigateAction.pop(),
        ),
        pushViewBidsPage: () => dispatch(
          NavigateAction.pushNamed('/tradesman/view_bids_page'),
        ),
        userBid: state.userBid,
        loading: state.wait.isWaiting,
        dispatchPlaceBidAction: ({required int price, File? quote}) =>
            dispatch(PlaceBidAction(price: price, quote: quote)),
        dispatchGetOtherUserAction: () =>
            dispatch(GetOtherUserAction(state.activeAd!.userId)),
        dispatchRecordPlaceBidAction: (type, amount) => dispatch(
          RecordPlaceBidAction(
            type: type,
            amount: amount,
          ),
        ),
        accepted: state.userBid == null
            ? false
            : state.activeAd!.acceptedBid == null
                ? false
                : state.userBid!.userId == state.activeAd!.acceptedBid!,
        change: state.change,
        dispatchOpenInMapsAction: (BuildContext context) =>
            dispatch(OpenInMapsAction(context)),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;
  final AdvertModel advert;
  final BidModel? userBid;
  final int bidCount;
  final VoidCallback pushViewBidsPage;
  final bool loading;
  final void Function(String, int) dispatchRecordPlaceBidAction;
  final void Function({
    required int price,
    File? quote,
  }) dispatchPlaceBidAction;
  final VoidCallback dispatchGetOtherUserAction;
  final void Function(BuildContext context) dispatchOpenInMapsAction;
  final bool accepted;
  final bool change;

  _ViewModel({
    required this.advert,
    required this.change,
    required this.bidCount,
    required this.userBid,
    required this.dispatchPlaceBidAction,
    required this.dispatchGetOtherUserAction,
    required this.popPage,
    required this.pushViewBidsPage,
    required this.loading,
    required this.dispatchRecordPlaceBidAction,
    required this.accepted,
    required this.dispatchOpenInMapsAction,
  }) : super(equals: [advert, loading, userBid, change]);
}
