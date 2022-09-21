import 'package:async_redux/async_redux.dart';
import 'package:general/methods/time.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/image_carousel_widget.dart';
import 'package:general/widgets/job_card.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';
import '../widgets/long_button_widget.dart';

class ArchivedAdvertDetailsPage extends StatelessWidget {
  final Store<AppState> store;

  const ArchivedAdvertDetailsPage({Key? key, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //this are where we do the images

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
                      editButton: false,
                    ),
                  //*******************************************//

                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: LongButtonWidget(
                      text: "View Bids (${vm.bidCount})",
                      backgroundColor:
                          vm.bidCount == 0 ? Colors.grey : Colors.orange,
                      function: () {
                        if (vm.bidCount != 0) vm.pushViewBidsPage();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
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
          NavigateAction.pushNamed('/consumer/view_bids'),
        ),
        popPage: () => dispatch(NavigateAction.pop()),
        advert: state.activeAd!,
        loading: state.wait.isWaiting,
        bidCount: state.bids.length + state.shortlistBids.length,
      );
}

// view model
class _ViewModel extends Vm {
  final AdvertModel advert;
  final VoidCallback pushViewBidsPage;
  final VoidCallback popPage;
  final int bidCount;
  final bool loading;

  _ViewModel({
    required this.advert,
    required this.bidCount,
    required this.pushViewBidsPage,
    required this.popPage,
    required this.loading,
  }) : super(equals: [advert, loading]); // implementinf hashcode
}
