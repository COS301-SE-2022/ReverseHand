import 'package:async_redux/async_redux.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:general/methods/time.dart';
import 'package:general/widgets/appbar.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:general/widgets/image_carousel_widget.dart';
import 'package:general/widgets/job_card.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/adverts/archive_advert_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/actions/chat/delete_chat_action.dart';
import '../widgets/delete_advert_popup.dart';
import '../widgets/light_dialog_helper.dart';
import '../widgets/rating_popup.dart';
import 'package:general/widgets/long_button_transparent.dart';

class AdvertDetailsPage extends StatelessWidget {
  final Store<AppState> store;

  const AdvertDetailsPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) {
                return Column(
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
                        editButton: true,
                      ),
                    //*******************************************//

                    //extra padding if there is an accepted bid
                    if (vm.advert.acceptedBid != null)
                      const Padding(padding: EdgeInsets.all(30)),

                    const Padding(padding: EdgeInsets.only(top: 20)),

                    //*************BOTTOM BUTTONS**************//
                    if (vm.advert.acceptedBid == null)
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          children: [
                            LongButtonWidget(
                              text: "View Bids (${vm.bidCount})",
                              backgroundColor: vm.bidCount == 0
                                  ? Colors.grey
                                  : Colors.orange,
                              function: () {
                                if (vm.bidCount != 0) vm.pushViewBidsPage();
                              },
                            ),
                            TransparentLongButtonWidget(
                              text: "Delete",
                              function: () {
                                LightDialogHelper.display(
                                  context,
                                  DeletePopUpWidget(
                                    action: () =>
                                        vm.dispatchArchiveAdvertAction(),
                                  ),
                                  320.0,
                                );
                              },
                            )
                          ],
                        ),
                      ),

                    //should only be displayed if a bid has been accepted
                    if (vm.advert.acceptedBid != null)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.white70,
                                  size: 20,
                                ),
                                Padding(padding: EdgeInsets.all(2)),
                                Text(
                                  "Close the job once all contractor\nservices have been completed",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 15)),
                          LongButtonWidget(
                            text: "Close",
                            function: () {
                              LightDialogHelper.display(
                                context,
                                RatingPopUpWidget(
                                  store: store,
                                  onPressed: () {
                                    // reason not inside Rating popup is to make it general and reusable
                                    vm.dispatchDeleteChatAction();
                                    vm.dispatchArchiveAdvertAction();
                                    vm.pushConsumerListings();
                                  },
                                ),
                                1000.0,
                              );
                            },
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 50)),
                        ],
                      ),
                  ],
                );
              }),
        ),
        //************************NAVBAR***********************/
        bottomNavigationBar: NavBarWidget(
          store: store,
        ),
        //*************************************************//
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, AdvertDetailsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        pushViewBidsPage: () => dispatch(
          NavigateAction.pushNamed('/consumer/view_bids'),
        ),
        pushConsumerListings: () => dispatch(
          NavigateAction.pushNamed('/consumer'),
        ),
        popPage: () => dispatch(NavigateAction.pop()),
        advert: state.activeAd!,
        dispatchDeleteChatAction: () => dispatch(DeleteChatAction()),
        dispatchArchiveAdvertAction: () {
          dispatch(ArchiveAdvertAction());
          dispatch(NavigateAction.pop());
        },
        loading: state.wait.isWaiting,
        bidCount: state.bids.length + state.shortlistBids.length,
      );
}

// view model
class _ViewModel extends Vm {
  final AdvertModel advert;
  final VoidCallback pushViewBidsPage;
  final VoidCallback pushConsumerListings;
  final VoidCallback popPage;
  final int bidCount;
  final VoidCallback dispatchDeleteChatAction;
  final VoidCallback
      dispatchArchiveAdvertAction; // the buttonn says delete but we are in actual fact archiving
  final bool loading;

  _ViewModel({
    required this.dispatchDeleteChatAction,
    required this.advert,
    required this.bidCount,
    required this.pushViewBidsPage,
    required this.pushConsumerListings,
    required this.popPage,
    required this.dispatchArchiveAdvertAction,
    required this.loading,
  }) : super(equals: [advert, loading]); // implementinf hashcode
}
