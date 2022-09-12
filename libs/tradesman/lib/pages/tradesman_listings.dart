import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/list_refresh_widget.dart';
import 'package:redux_comp/actions/adverts/view_jobs_action.dart';
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
            builder: (BuildContext context, _ViewModel vm) {
              Widget appbar = AppBarWidget(title: "JOB LISTINGS", store: store);
              return (vm.loading) ? Column(children: [
                //*******************APP BAR WIDGET*********************//
                appbar, 
                //********************************************************//
                const Padding(padding: EdgeInsets.only(top: 20)),

                const LoadingWidget(topPadding: 80, bottomPadding: 0)

              ],) : Column(
                children: [
                  //*******************APP BAR WIDGET*********************//
                  appbar,
                  //********************************************************//

                  const Padding(padding: EdgeInsets.only(top: 20)),

                  ListRefreshWidget(
                    refreshFunction: () {
                      vm.dispatchViewJobs();
                    },
                    widgets: populateAdverts(vm.adverts, store),
                  ),

                  // ...populateAdverts(vm.adverts, store),

                  //************MESSAGE IF THERE ARE NO ADVERTS***********/
                  if (vm.adverts.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                          top: (MediaQuery.of(context).size.height) / 3),
                      child: const Text(
                        "There are no jobs to display.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white70),
                      ),
                    ),
                  //*****************************************************/
                ],
              );
            }),

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
        dispatchViewJobs: () => dispatch(ViewJobsAction()),
      );
}

// view model
class _ViewModel extends Vm {
  final List<AdvertModel> adverts;
  final bool loading;
  final void Function() dispatchViewJobs;

  _ViewModel({
    required this.adverts,
    required this.loading,
    required this.dispatchViewJobs,
  }) : super(equals: [adverts, loading]);
}
