import 'package:async_redux/async_redux.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:general/methods/time.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/hint_widget.dart';
import 'package:general/widgets/image_carousel_widget.dart';
import 'package:general/widgets/job_card.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/models/bid_model.dart';
import 'package:tradesman/widgets/tradesman_navbar_widget.dart';
import '../widgets/long_button_transparent.dart';
import '../widgets/long_button_widget.dart';
import '../widgets/user_bid_details_widget.dart';
import 'package:redux_comp/actions/user/get_other_user_action.dart';

class ArchivedAdvertDetailsPage extends StatelessWidget {
  final Store<AppState> store;

  const ArchivedAdvertDetailsPage({Key? key, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //this are where we do the images

    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(this),
        builder: (BuildContext context, _ViewModel vm) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //**********APPBAR***********//
                  AppBarWidget(
                      title: "JOB INFO", store: store, backButton: true),
                  //*******************************************//

                  //******************CAROUSEL ****************//
                  if (vm.advert.images.isNotEmpty)
                    ImageCarouselWidget(images: vm.advert.images),
                  //*******************************************//

                  if (vm.loading)
                    const LoadingWidget(topPadding: 80, bottomPadding: 0)
                  else
                    JobCardWidget(
                      titleText: vm.advert.title,
                      descText: vm.advert.description ?? "",
                      location: vm.advert.domain.city,
                      type: vm.advert.type,
                      date: timestampToDate(vm.advert.dateCreated),
                      editButton: false,
                    ),
                  //*******************************************//

                  //*******************************************//
                  // User/Won bid
                  if (vm.bid != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 20),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, bottom: 12),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 232, 232, 232),
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        ),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: HintWidget(
                                  text: "Accepted Bid",
                                  colour: Colors.black,
                                  padding: 0),
                            ),
                            UserBidDetailsWidget(
                              amount: vm.bid!.amount(),
                              quote: vm.bid!.quote != null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  //*******************************************//
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: LongButtonWidget(
                      text: "View Bids (${vm.bidCount})",
                      backgroundColor:
                          vm.bidCount == 0 ? Colors.grey : Colors.orange,
                      function: () {
                        if (vm.bidCount != 0) vm.pushViewBidsPage();
                      },
                    ),
                  ),

                  if (vm.isTradsman)
                    TransparentLongButtonWidget(
                      text: "View Client Profile",
                      function: vm.dispatchGetOtherUserAction,
                    ),
                ],
              ),
            ),
            bottomNavigationBar: vm.isTradsman
                ? TNavBarWidget(store: store)
                : NavBarWidget(store: store),
          );
        },
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ArchivedAdvertDetailsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        pushViewBidsPage: () => dispatch(
          NavigateAction.pushNamed('/archived_view_bids', arguments: true),
        ),
        popPage: () => dispatch(NavigateAction.pop()),
        advert: state.activeAd!,
        loading: state.wait.isWaiting,
        bidCount: state.bids.length + state.shortlistBids.length,
        bid: state.userBid ?? state.activeBid,
        isTradsman: state.userDetails.userType == 'Tradesman',
        dispatchGetOtherUserAction: () =>
            dispatch(GetOtherUserAction(state.activeAd!.userId)),
      );
}

// view model
class _ViewModel extends Vm {
  final AdvertModel advert;
  final VoidCallback pushViewBidsPage;
  final VoidCallback popPage;
  final int bidCount;
  final bool loading;
  final BidModel? bid;
  final bool isTradsman;
  final VoidCallback dispatchGetOtherUserAction;

  _ViewModel({
    required this.bid,
    required this.advert,
    required this.bidCount,
    required this.pushViewBidsPage,
    required this.popPage,
    required this.loading,
    required this.isTradsman,
    required this.dispatchGetOtherUserAction,
  }) : super(equals: [advert, loading]); // implementinf hashcode
}
