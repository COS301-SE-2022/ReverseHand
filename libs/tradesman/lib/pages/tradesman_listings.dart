import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:tradesman/widgets/tradesman_floating_button.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:tradesman/methods/populate_adverts.dart';
import 'package:redux_comp/redux_comp.dart';
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
                AppBarWidget(title: "JOB LISTINGS", store: store),
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
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "MY BIDS",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                //********************************************************//

                Expanded(
                    child: TabBarView(children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        //display loading icon
                        if (vm.loading)
                          const LoadingWidget(topPadding: 80, bottomPadding: 0)
                        //a message if no jobs
                        else if (populateAdverts(vm.adverts, store).isEmpty)
                          Padding(
                            padding: EdgeInsets.only(
                                top: (MediaQuery.of(context).size.height) / 4,
                                left: 40,
                                right: 40),
                            child: (const Text(
                              "There are no jobs to display.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white70),
                            )),
                          ),
                        //else populate the jobs
                        ...populateAdverts(vm.adverts, store),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: const [
                        //the jobs that have been bid on should go here
                      ],
                    ),
                  ),
                ])),

                if (vm.loading)
                  const LoadingWidget(topPadding: 80, bottomPadding: 0)
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
        loading: state.wait.isWaiting,
      );
}

// view model
class _ViewModel extends Vm {
  final List<AdvertModel> adverts;
  final bool loading;

  _ViewModel({
    required this.adverts,
    required this.loading,
  }) : super(equals: [adverts, loading]);
}
