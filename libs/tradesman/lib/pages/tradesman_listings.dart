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

class TradesmanJobListings extends StatelessWidget {
  final Store<AppState> store;
  const TradesmanJobListings({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) =>
              DefaultTabController(
            length: 2,
            child: Column(
              children: [
                //*******************APP BAR WIDGET*********************//
                AppBarWidget(
                  store: store,
                  title: "Job Listing",
                ),
                //********************************************************//

                //*******************TAB BAR LABELS***********************//
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TabBar(
                    // onTap: (int index) {
                    //   if (index == 0) {
                    //     vm.dispatchGetJobsAction();
                    //   } else {
                    //     vm.dispatchGetBidOnJobsAction();
                    //   }
                    // },
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
                      //display loading icon
                      if (vm.loading)
                        const LoadingWidget(
                            topPadding: 50, bottomPadding: 20),
                      ListRefreshWidget(
                        widgets: [
                          //a message if no jobs
                          if (vm.adverts.isEmpty)
                            Padding(
                              padding: EdgeInsets.only(
                                top: (MediaQuery.of(context).size.height) / 4,
                                left: 40,
                                right: 40,
                              ),
                              child: (const Text(
                                "There are no jobs to display.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white70),
                              )),
                            ),
                          //else populate the jobs
                          ...populateAdverts(vm.adverts, store),
                          const Padding(padding: EdgeInsets.only(bottom: 33))
                        ],
                        refreshFunction: vm.dispatchGetJobsAction,
                      ),
                      //display loading icon
                      if (vm.loading)
                        const LoadingWidget(
                            topPadding: 80, bottomPadding: 0),
                      ListRefreshWidget(
                        widgets: [
                          //a message if no jobs
                          if (vm.bidOnAdverts.isEmpty)
                            Padding(
                              padding: EdgeInsets.only(
                                top: (MediaQuery.of(context).size.height) / 4,
                                left: 40,
                                right: 40,
                              ),
                              child: (const Text(
                                "There are no jobs to display.\n Bid on an advert to see it here.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white70),
                              )),
                            ),
                          //else populate the jobs
                          ...populateAdverts(vm.bidOnAdverts, store),
                          const Padding(padding: EdgeInsets.only(bottom: 33))
                        ],
                        refreshFunction: vm.dispatchGetBidOnJobsAction,
                      ),
                    ],
                  ),
                ),

                // if (vm.loading)
                //   const LoadingWidget(topPadding: 80, bottomPadding: 0)
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
                  store: store,
                ),
                MediaQuery.of(context).size.height);
          },
          type: "filter",
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: TNavBarWidget(
          store: store,
        ),
        //*****************************************************/
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, TradesmanJobListings> {
  _Factory(widget) : super(widget);
  @override
  _ViewModel fromStore() => _ViewModel(
        adverts: state.viewAdverts,
        bidOnAdverts: state.bidOnAdverts,
        loading: state.wait.isWaiting,
        dispatchGetBidOnJobsAction: () => dispatch(GetBidOnAdvertsAction()),
        dispatchGetJobsAction: () => dispatch(ViewJobsAction()),
      );
}

// view model
class _ViewModel extends Vm {
  final List<AdvertModel> adverts;
  final List<AdvertModel> bidOnAdverts;
  final bool loading;
  final VoidCallback dispatchGetJobsAction;
  final VoidCallback dispatchGetBidOnJobsAction;

  _ViewModel({
    required this.adverts,
    required this.bidOnAdverts,
    required this.loading,
    required this.dispatchGetBidOnJobsAction,
    required this.dispatchGetJobsAction,
  }) : super(equals: [adverts, loading, bidOnAdverts]);
}
