import 'package:async_redux/async_redux.dart';
import 'package:consumer/widgets/consumer_navbar.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/appbar.dart';
import 'package:tradesman/widgets/tradesman_navbar_widget.dart';

class ArchivedJobsPage extends StatelessWidget {
  final Store<AppState> store;
  const ArchivedJobsPage({Key? key, required this.store}) : super(key: key);

  //*****Calls method display all active jobs made by a consumer*****//
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(this),
        builder: (BuildContext context, _ViewModel vm) {
          List<Widget> advertWidgets = vm.adverts
              .map(
                (a) => QuickViewJobCardWidget(
                  advert: a,
                  store: store,
                  archived: true,
                ),
              )
              .toList();

          return Scaffold(
            body: Column(
              children: [
                //*******************APP BAR WIDGET*********************//
                AppBarWidget(title: "MY PAST JOBS", store: store, backButton: true),
                //********************************************************//

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //display loading icon
                        if (vm.loading)
                          const LoadingWidget(topPadding: 80, bottomPadding: 0)
                        //a message if no jobs
                        else if (advertWidgets.isEmpty)
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 4,
                                left: 40,
                                right: 40),
                            child: (const Text(
                              "You do not have any past jobs.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white70),
                            )),
                          ),
                        //else populate the jobs
                        const Padding(padding: EdgeInsets.only(top: 15),),
                        ...advertWidgets
                      ],
                    ),
                  ),
                ),
                //********************************************************//
              ],
            ),
            bottomNavigationBar: vm.isTradsman
                ? TNavBarWidget(store: store)
                : NavBarWidget(store: store),
          );
        },
        //*****************************************************/
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ArchivedJobsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        adverts: state.archivedJobs,
        isTradsman: state.userDetails.userType == 'Tradesman',
      );
}

// view model
class _ViewModel extends Vm {
  final List<AdvertModel> adverts;
  final bool loading;
  final bool isTradsman;

  _ViewModel({
    required this.loading,
    required this.adverts,
    required this.isTradsman,
  }) : super(equals: [adverts, loading]); // implementinf hashcode
}
