import 'package:async_redux/async_redux.dart';
import 'package:authentication/widgets/auth_button.dart';
import 'package:general/methods/time.dart';
import 'package:general/widgets/appbar.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:general/widgets/job_card.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/adverts/archive_advert_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/actions/chat/delete_chat_action.dart';
import '../widgets/delete_advert_popup.dart';
import '../widgets/light_dialog_helper.dart';

class AdvertDetailsPage extends StatelessWidget {
  final Store<AppState> store;

  const AdvertDetailsPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        // backgroundColor: Theme.of(context).primaryColorLight,

        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) {
                return Column(
                  children: [
                    //**********APPBAR***********//
                    AppBarWidget(title: "JOB INFO", store: store),
                    //*******************************************//

                    //**********DETAILED JOB INFORMATION***********//
                    JobCardWidget(
                      titleText: vm.advert.title,
                      descText: vm.advert.description ?? "",
                      location: vm.advert.domain.city,
                      type: vm.advert.type ?? "",
                      date: timestampToDate(vm.advert.dateCreated),
                    ),
                    //*******************************************//

                    //******************EDIT ICON****************//
                    //should only be displayed if no bid has been accepted
                    if (vm.advert.acceptedBid == null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: IconButton(
                          onPressed: vm.pushEditAdvert,
                          icon: const Icon(Icons.edit),
                          color: Colors.white70,
                        ),
                      ),
                    //**********************************************/

                    //extra padding if there is an accepted bid
                    if (vm.advert.acceptedBid != null)
                      (const Padding(padding: EdgeInsets.all(40))),

                    const Padding(padding: EdgeInsets.only(top: 20)),

                    //*************BOTTOM BUTTONS**************//
                    if (vm.advert.acceptedBid == null)
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          children: [
                            AuthButtonWidget(
                                text: "View Bids",
                                function: () {
                                  vm.pushViewBidsPage();
                                }),
                            SizedBox(
                              width: 290,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  shadowColor: Colors.black,
                                  elevation: 9,
                                  side: const BorderSide(color: Colors.orange),
                                  textStyle: const TextStyle(fontSize: 20),
                                  minimumSize: const Size(400, 50),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0))),
                                ),
                                onPressed: () {
                                  LightDialogHelper.display(
                                      context,
                                      DeletePopUpWidget(
                                        action: vm.dispatchArchiveAdvertAction,
                                      ),
                                      320.0);
                                },
                                child: const Text("Delete"),
                              ),
                            ),
                          ],
                        ),
                      ),

                    //should only be displayed if a bid has been accepted
                    // if (vm.advert.acceptedBid != null)
                    //   ButtonWidget(
                    //     text: "Close job",
                    //     function: () {
                    //       LightDialogHelper.display(context,
                    //           RatingPopUpWidget(
                    //         onPressed: () {
                    //           vm.dispatchDeleteChatAction();
                    //           vm.pushConsumerListings();
                    //         },
                    //       ), 1000.0);
                    //     },
                    //   ),

                    // //Delete
                    // if (vm.advert.acceptedBid == null)
                    //   ButtonWidget(
                    //     text: "Delete",
                    //     color: "light",
                    //     function: () {
                    //       LightDialogHelper.display(
                    //           context,
                    //           DeletePopUpWidget(
                    //             action: vm.dispatchArchiveAdvertAction,
                    //           ),
                    //           320.0);
                    //     },
                    //   ),

                    //Back - if no bid accepted yet
                    // if (vm.advert.acceptedBid == null)
                    //   (ButtonWidget(
                    //     text: "Back",
                    //     color: "light",
                    //     border: "white",
                    //     function: vm.popPage,
                    //   )),

                    //Back - if bid accepted
                    // if (vm.advert.acceptedBid != null)
                    //   (ButtonWidget(
                    //     text: "Back",
                    //     color: "light",
                    //     border: "white",
                    //     function: vm.popPage,
                    //   )),
                    //*************BOTTOM BUTTONS**************//
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
        pushEditAdvert: () => dispatch(
          NavigateAction.pushNamed('/consumer/edit_advert_page'),
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
      );
}

// view model
class _ViewModel extends Vm {
  final AdvertModel advert;
  final VoidCallback pushViewBidsPage;
  final VoidCallback pushEditAdvert;
  final VoidCallback pushConsumerListings;
  final VoidCallback popPage;
  final VoidCallback dispatchDeleteChatAction;
  final VoidCallback
      dispatchArchiveAdvertAction; // the buttonn says delete but we are in actual fact archiving

  _ViewModel({
    required this.dispatchDeleteChatAction,
    required this.advert,
    required this.pushEditAdvert,
    required this.pushViewBidsPage,
    required this.pushConsumerListings,
    required this.popPage,
    required this.dispatchArchiveAdvertAction,
  }) : super(equals: [advert]); // implementinf hashcode
}
