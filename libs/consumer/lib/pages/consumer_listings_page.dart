import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:general/widgets/quick_view_job_card.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/navbar.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/floating_button.dart';

class ConsumerListingsPage extends StatelessWidget {
  final Store<AppState> store;
  const ConsumerListingsPage({Key? key, required this.store}) : super(key: key);

  //*****Calls method display all active jobs made by a consumer*****//
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: Scaffold(
          body: SingleChildScrollView(
            child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) {
                List<Widget> open = [];
                List<Widget> inProgress = [];

                for (AdvertModel advert in vm.adverts) {
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

                return Column(
                  children: [
                    //*******************APP BAR WIDGET*********************//
                    const AppBarWidget(title: "MY JOBS"),
                    //********************************************************//

                    //if there are adverts, heading should be displayed
                    if (vm.adverts.isNotEmpty)
                      Column(
                        children: [
                          //******************OPEN HEADING***********************//
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 18.0),
                              child: Text(
                                "OPEN",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white60),
                              ),
                            ),
                          ),
                          //******************************************************//

                          //**************************DIVIDER**********************//
                          Divider(
                            height: 20,
                            thickness: 0.5,
                            indent: 15,
                            endIndent: 15,
                            color: Theme.of(context).primaryColorLight,
                          ),
                          //******************************************************//
                        ],
                      ),

                    // populating column with adverts
                    if (vm.loading) const LoadingWidget(),

                    // ...populateAdverts(vm.adverts, store),
                    ...open,

                    //************MESSAGE IF THERE ARE NO ADVERTS***********/
                    if (vm.adverts.isEmpty)
                      Padding(
                        padding: EdgeInsets.only(
                            top: (MediaQuery.of(context).size.height) / 3),
                        child: const Text(
                          "There are no\n active jobs",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25, color: Colors.white54),
                        ),
                      ),
                    //*****************************************************/
                    if (vm.adverts.isNotEmpty)
                      Column(
                        children: [
                          //******************OPEN HEADING***********************//
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10, left: 18.0),
                              child: Text(
                                "IN PROGRESS",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white60),
                              ),
                            ),
                          ),
                          //******************************************************//

                          ...inProgress,

                          //**************************DIVIDER**********************//
                          Divider(
                            height: 20,
                            thickness: 0.5,
                            indent: 15,
                            endIndent: 15,
                            color: Theme.of(context).primaryColorLight,
                          ),
                          //******************************************************//
                        ],
                      ),
                  ],
                );
              },
            ),
          ),

          //************************NAVBAR***********************/
          floatingActionButton: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) =>
                FloatingButtonWidget(
              function: vm.pushCreateAdvertPage,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,

          bottomNavigationBar: NavBarWidget(
            store: store,
          ),
          //*****************************************************/
        ),
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
