import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/list_refresh_widget.dart';
import 'package:redux_comp/actions/adverts/view_jobs_action.dart';
import 'package:tradesman/widgets/tradesman_floating_button.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:tradesman/methods/populate_adverts.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:redux_comp/actions/adverts/get_bid_on_adverts_action.dart';
import 'package:general/widgets/loading_widget.dart';
import '../widgets/tradesman_navbar_widget.dart';
import '../widgets/tradesman_filter_popup.dart';
import 'package:general/widgets/dark_dialog_helper.dart';

class TradesmanJobListings extends StatefulWidget {
  final Store<AppState> store;
  const TradesmanJobListings({Key? key, required this.store}) : super(key: key);

  @override
  State<TradesmanJobListings> createState() => _TradesmanJobListingsState();
}

class _TradesmanJobListingsState extends State<TradesmanJobListings> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) => (vm.loading)
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      //**********APPBAR***********//
                      AppBarWidget(
                        store: widget.store,
                        title: "Job Listing",
                      ),
                      //*******************************************//

                      LoadingWidget(
                        topPadding: MediaQuery.of(context).size.height / 3,
                        bottomPadding: 0,
                      )
                    ],
                  ),
                )
              : DefaultTabController(
                  initialIndex: index,
                  length: 2,
                  child: Column(
                    children: [
                      //*******************APP BAR WIDGET*********************//
                      AppBarWidget(
                        store: widget.store,
                        title: "Job Listing",
                      ),
                      //********************************************************//

                      //*******************TAB BAR LABELS***********************//
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TabBar(
                          indicatorColor: Theme.of(context).primaryColor,
                          tabs: const [
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "OPEN JOBS",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "MY BIDS",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //********************************************************//

                      Expanded(
                        child: TabBarView(
                          children: [
                            Column(
                              children: [
                                vm.adverts.isEmpty
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                          top: (MediaQuery.of(context)
                                                  .size
                                                  .height) /
                                              4,
                                          left: 40,
                                          right: 40,
                                        ),
                                        child: const Text(
                                          "There are no jobs to display.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white70),
                                        ),
                                      )
                                    : ListRefreshWidget(
                                        widgets: populateAdverts(
                                            vm.adverts, widget.store),
                                        refreshFunction: () {
                                          vm.dispatchGetJobsAction();
                                          index = 0;
                                        },
                                      ),
                              ],
                            ),
                            Column(
                              children: [
                                vm.bidOnAdverts.isEmpty
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                          top: (MediaQuery.of(context)
                                                  .size
                                                  .height) /
                                              4,
                                          left: 40,
                                          right: 40,
                                        ),
                                        child: const Text(
                                          "There are no jobs to display.\n Bid on an advert to see it here.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white70),
                                        ),
                                      )
                                    : ListRefreshWidget(
                                        widgets: populateAdverts(
                                            vm.bidOnAdverts, widget.store),
                                        refreshFunction: () {
                                          vm.dispatchGetBidOnJobsAction();
                                          index = 1;
                                        },
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
        //************************NAVBAR***********************/
        floatingActionButton: TradesmanFloatingButtonWidget(
          function: () {
            DarkDialogHelper.display(
                context,
                FilterPopUpWidget(
                  store: widget.store,
                ),
                MediaQuery.of(context).size.height);
          },
          type: "filter",
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: TNavBarWidget(
          store: widget.store,
        ),
        //*****************************************************/
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, _TradesmanJobListingsState> {
  _Factory(widget) : super(widget);
  @override
  _ViewModel fromStore() => _ViewModel(
        adverts: state.viewAdverts,
        bidOnAdverts: state.bidOnAdverts,
        loading: state.wait.isWaiting,
        dispatchGetBidOnJobsAction: () => dispatch(GetBidOnAdvertsAction()),
        dispatchGetJobsAction: () => dispatch(ViewJobsAction()),
        change: state.change,
      );
}

// view model
class _ViewModel extends Vm {
  final List<AdvertModel> adverts;
  final List<AdvertModel> bidOnAdverts;
  final bool loading;
  final VoidCallback dispatchGetJobsAction;
  final VoidCallback dispatchGetBidOnJobsAction;
  final bool change;

  _ViewModel({
    required this.adverts,
    required this.change,
    required this.bidOnAdverts,
    required this.loading,
    required this.dispatchGetBidOnJobsAction,
    required this.dispatchGetJobsAction,
  }) : super(equals: [adverts, loading, bidOnAdverts]);
}
