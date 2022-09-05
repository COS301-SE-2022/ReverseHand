import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:consumer/widgets/consumer_floating_button.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:general/widgets/appbar.dart';

class ConsumerListingsPage extends StatelessWidget {
  final Store<AppState> store;
  const ConsumerListingsPage({Key? key, required this.store}) : super(key: key);

  //*****Calls method display all active jobs made by a consumer*****//
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            List<Widget> open = [];
            List<Widget> inProgress = [];
            for (AdvertModel advert in vm.adverts) {
              if (advert.dateClosed != null) {
                continue;
              }

              if (advert.acceptedBid == null) {
                open.add(
                  QuickViewJobCardWidget(
                    advert: advert,
                    store: store,
                  ),
                );
              } else {
                inProgress.add(
                  QuickViewJobCardWidget(
                    advert: advert,
                    store: store,
                  ),
                );
              }
            }

            return DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    //*******************APP BAR WIDGET*********************//
                    AppBarWidget(title: "MY JOBS", store: store),
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
                              "OPEN",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "IN PROGRESS",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //********************************************************//

                    //*********************TAB FUNCTIONALITY******************//
                    Expanded(
                        child: TabBarView(children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            //display loading icon
                            if (vm.loading)
                              const LoadingWidget(topPadding: 80, bottomPadding: 0)
                            //a message if no jobs
                            else if (open.isEmpty)
                              const Padding(
                                padding: EdgeInsets.fromLTRB(40, 100, 40, 40),
                                child: (Text(
                                  "You do not have any active jobs. Create a new job to see it here and enable contractors to start bidding.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white70),
                                )),
                              ),
                            //else populate the jobs
                            ...open
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            //a message if no in progress jobs
                            if (inProgress.isEmpty)
                              const Padding(
                                padding: EdgeInsets.fromLTRB(40, 100, 40, 40),
                                child: (Text(
                                  "No jobs are currently in progress. Only jobs with accepted bids are displayed here.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white70),
                                )),
                              ),
                            //else display in progress jobs
                            ...inProgress
                          ],
                        ),
                      ),
                    ])),
                    //********************************************************//
                  ],
                ));
          },
        ),

        //************************NAVBAR***********************/
        floatingActionButton: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) =>
              ConsumerFloatingButtonWidget(
            function: vm.pushCreateAdvertPage,
            type: "add",
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: NavBarWidget(
          store: store,
        ),
        //*****************************************************/
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ConsumerListingsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        adverts: state.adverts,
        pushCreateAdvertPage: () => dispatch(
          NavigateAction.pushNamed('/consumer/create_advert'),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushCreateAdvertPage;
  final List<AdvertModel> adverts;
  final bool loading;

  _ViewModel({
    required this.loading,
    required this.adverts,
    required this.pushCreateAdvertPage,
  }) : super(equals: [adverts, loading]); // implementinf hashcode
}
