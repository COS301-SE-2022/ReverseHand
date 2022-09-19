import 'package:async_redux/async_redux.dart';
import 'package:general/widgets/appbar_popup_menu_widget.dart';
import 'package:general/widgets/hint_widget.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:general/methods/time.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/image_carousel_widget.dart';
import 'package:general/widgets/job_card.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/admin/app_management/add_advert_report_action.dart';
import 'package:redux_comp/actions/bids/place_bid_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/admin/app_management/models/report_user_details_model.dart';
import 'package:redux_comp/models/admin/app_management/report_details_model.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
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
              //formatting the amount
              String v = "null";
              if (vm.currentBid != null) {
                v = vm.currentBid!.price.toString();
                v = '${v.substring(0, v.length - 2)}.00';
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    //**********APPBAR***********//
                    AppBarWidget(
                        title: "JOB INFO",
                        store: store,
                        filterActions:
                            AppbarPopUpMenuWidget(store: store, functions: {
                          "Report Advert": () {
                            vm.dispatchReportAdvertAction(
                              advertId: vm.advert.id,
                              userId: vm.advert.customerId,
                              report: ReportDetailsModel(
                                description: "testing report",
                                reason: "Reason",
                                reporterUser: ReportUserDetailsModel(
                                  id: vm.userDetails.id,
                                  name: vm.userDetails.name!,
                                ),
                              ),
                            );
                          }
                        }),
                        backButton: true),
                    //*******************************************//

                    //******************CAROUSEL ****************//
                    if (vm.advertImages.isNotEmpty)
                      ImageCarouselWidget(images: vm.advertImages),
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
                          store: store),

                    const Padding(padding: EdgeInsets.only(top: 25)),

                    //*************BOTTOM BUTTONS**************//
                    vm.bids.contains(vm.currentBid)
                        //this isn't working as expected
                        // vm.currentBid != null
                        //if this contractor has already made a bid
                        ? Column(
                            children: [
                              //*************USER BID**************//
                              const Padding(
                                padding: EdgeInsets.only(left: 45.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: HintWidget(
                                      text: "Click on your bid to edit it",
                                      colour: Colors.white70,
                                      padding: 0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 40, right: 40, bottom: 50, top: 10),
                                child: InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                        ),
                                        builder: (BuildContext context) {
                                          return EditBidSheet();
                                        });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 232, 232, 232),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(7.0)),
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'R$v',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10)),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                'Quote:',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                //keeping this here so that a bid can still be made while we create the last UI
                                // DarkDialogHelper.display(
                                //     context, PlaceBidPopupWidget(store: store), 1000.0);
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

                                vm.dispatchPlaceBidAction(
                                    price: items['price'],
                                    quote: items['quote']);
                              },
                            ),
                          ),
                    //place bid

                    TransparentLongButtonWidget(
                        text: "View Bids", function: vm.pushViewBidsPage),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    TransparentLongButtonWidget(
                        text: "View Client Profile",
                        function: vm.pushLimitedProfilePage),
                    const Padding(padding: EdgeInsets.only(top: 35)),

                    const Padding(padding: EdgeInsets.only(bottom: 50)),
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
        bids: state.bids + state.shortlistBids,
        userDetails: state.userDetails,
        popPage: () => dispatch(
          NavigateAction.pop(),
        ),
        pushViewBidsPage: () => dispatch(
          NavigateAction.pushNamed('/tradesman/view_bids_page'),
        ),
        pushConsumerListings: () => dispatch(
          NavigateAction.pushNamed('/tradesman'),
        ),
        pushLimitedProfilePage: () => dispatch(
            NavigateAction.pushNamed('/consumer/limited_profile_page')),
        currentBid: state.userBid,
        advertImages: state.advertImages,
        loading: state.wait.isWaiting,
        dispatchPlaceBidAction: ({required int price, String? quote}) =>
            dispatch(PlaceBidAction(price: price, quote: quote)),
        dispatchReportAdvertAction: ({
          required String advertId,
          required String userId,
          required ReportDetailsModel report,
        }) =>
            dispatch(
          AddAdvertReportAction(
            advertId: advertId,
            userId: userId,
            report: report,
          ),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;
  final UserModel userDetails;
  final AdvertModel advert;
  final List<BidModel> bids;
  final BidModel? currentBid;
  final VoidCallback pushViewBidsPage;
  final VoidCallback pushConsumerListings;
  final VoidCallback pushLimitedProfilePage;
  final List<String> advertImages;
  final bool loading;
  final void Function({required int price, String? quote})
      dispatchPlaceBidAction;
  final void Function({
    required String advertId,
    required String userId,
    required ReportDetailsModel report,
  }) dispatchReportAdvertAction;

  _ViewModel({
    required this.advert,
    required this.bids,
    required this.userDetails,
    required this.dispatchPlaceBidAction,
    required this.dispatchReportAdvertAction,
    required this.currentBid,
    required this.popPage,
    required this.pushViewBidsPage,
    required this.pushConsumerListings,
    required this.pushLimitedProfilePage,
    required this.advertImages,
    required this.loading,
  }) : super(equals: [advert, advertImages, loading]);
}
