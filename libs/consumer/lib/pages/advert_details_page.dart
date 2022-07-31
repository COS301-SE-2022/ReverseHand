import 'package:async_redux/async_redux.dart';
import 'package:consumer/widgets/delete_advert_popup.dart';
import 'package:consumer/widgets/dialog_helper.dart';
import 'package:consumer/widgets/rating_popup.dart';
import 'package:general/theme.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/bottom_overlay.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/navbar.dart';
import 'package:general/widgets/job_card.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/actions/chat/delete_chat_action.dart';

class AdvertDetailsPage extends StatelessWidget {
  final Store<AppState> store;

  const AdvertDetailsPage({Key? key, required this.store}) : super(key: key);

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
                    location: vm.advert.location,
                    type: vm.advert.type ?? "",
                    date: vm.advert.dateCreated,
                    // location: advert.location ?? "",
                  ),

                  //*******************************************//

                  //******************EDIT ICON****************//
                  //should only be displayed if no bid has been accepted
                  if (vm.advert.acceptedBid == null)
                    (Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: IconButton(
                        onPressed: vm.pushEditAdvert,
                        icon: const Icon(Icons.edit),
                        color: Colors.white70,
                      ),
                    )),
                  //**********************************************/

                  //extra padding if there is an accepted bid
                  if (vm.advert.acceptedBid != null)
                    (const Padding(padding: EdgeInsets.all(40))),

                  const Padding(padding: EdgeInsets.only(top: 20)),

                  //*************BOTTOM BUTTONS**************//
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      BottomOverlayWidget(
                        height: MediaQuery.of(context).size.height / 2,
                      ),

                      //view bids
                      //should only be displayed if no bid is accepted yet
                      if (vm.advert.acceptedBid == null)
                        Positioned(
                          top: 15,
                          child: ButtonWidget(
                            text: "View Bids",
                            function: vm.pushViewBidsPage,
                          ),
                        ),

                      //should only be displayed if a bid has been accepted
                      if (vm.advert.acceptedBid != null)
                        Positioned(
                          top: 50,
                          child: ButtonWidget(
                            text: "Close job",
                            function: () {
                              DialogHelper.display(
                                context,
                                RatingPopUpWidget(
                                  onPressed: () {
                                    vm.dispatchDeleteChatAction();
                                    vm.pushConsumerListings();
                                  },
                                ),
                              );
                            },
                          ),
                        ),

                      //Delete - currently just takes you back to Consumer Listings page
                      if (vm.advert.acceptedBid == null)
                        Positioned(
                          top: 75,
                          child: ButtonWidget(
                            text: "Delete",
                            color: "light",
                            function: () {
                              DialogHelper.display(
                                context,
                                const DeletePopUpWidget(),
                              );
                            },
                          ),
                        ),

                      //Back - if no bid accepted yet
                      if (vm.advert.acceptedBid == null)
                        (Positioned(
                          top: 135,
                          child: ButtonWidget(
                            text: "Back",
                            color: "light",
                            border: "white",
                            function: vm.popPage,
                          ),
                        )),

                      //Back - if bid accepted
                      if (vm.advert.acceptedBid != null)
                        (Positioned(
                          top: 115,
                          child: ButtonWidget(
                            text: "Back",
                            color: "light",
                            border: "white",
                            function: vm.popPage,
                          ),
                        ))
                    ],
                  ),
                  //*************BOTTOM BUTTONS**************//
                ],
              ),
            ),
          ),
          //************************NAVBAR***********************/
          bottomNavigationBar: NavBarWidget(
            store: store,
          ),
          //*************************************************//
        ),
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

  _ViewModel({
    required this.dispatchDeleteChatAction,
    required this.advert,
    required this.pushEditAdvert,
    required this.pushViewBidsPage,
    required this.pushConsumerListings,
    required this.popPage,
  }) : super(equals: [advert]); // implementinf hashcode
}
