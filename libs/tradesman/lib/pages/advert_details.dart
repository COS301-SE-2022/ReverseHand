import 'dart:io';

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
import '../widgets/tradesman_navbar_widget.dart';

class TradesmanJobDetails extends StatelessWidget {
  final Store<AppState> store;
  const TradesmanJobDetails({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                if (vm.advertImages.isNotEmpty)
                  ImageCarouselWidget(images: vm.advertImages),
                //*******************************************//

                //**********DETAILED JOB INFORMATION***********//
                JobCardWidget(
                    titleText: vm.advert.title,
                    descText: vm.advert.description ?? "",
                    date: timestampToDate(vm.advert.dateCreated),
                    type: vm.advert.type,
                    location: vm.advert.domain.city,
                    store: store),

                const Padding(padding: EdgeInsets.only(top: 60)),

                //*************BOTTOM BUTTONS**************//
                AuthButtonWidget(
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
        advertImages: state.advertImages,
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
  final List<String> advertImages;

  _ViewModel({
    required this.advert,
    required this.bids,
    required this.popPage,
    required this.pushEditAdvert,
    required this.pushViewBidsPage,
    required this.pushConsumerListings,
    required this.advertImages,
  }) : super(equals: [advert, advertImages]);
}
