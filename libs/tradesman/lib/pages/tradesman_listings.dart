import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/appbar.dart';
import 'package:redux_comp/actions/user/logout_action.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:tradesman/methods/populate_adverts.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/loading_widget.dart';

import '../widgets/tradesman_navbar_widget.dart';

class TradesmanJobListings extends StatelessWidget {
  final Store<AppState> store;
  const TradesmanJobListings({Key? key, required this.store}) : super(key: key);

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
              builder: (BuildContext context, _ViewModel vm) => Column(
                children: [
                  //*******************APP BAR WIDGET*********************//
                    AppBarWidget(title: "JOB LISTINGS", store: store),
                    //********************************************************//
                  ...populateAdverts(vm.adverts, store),
                    if (vm.loading) const LoadingWidget()

                    //************MESSAGE IF THERE ARE NO ADVERTS***********/
                    else if (vm.adverts.isEmpty)
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
                ],
              ),
            ),
          ),
           //************************NAVBAR***********************/

          bottomNavigationBar: TNavBarWidget(
            store: store,
          ),
          //*****************************************************/
        ),
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, TradesmanJobListings> {
  _Factory(widget) : super(widget);
  @override
  _ViewModel fromStore() => _ViewModel(
        adverts: state.adverts,
        loading: state.wait.isWaiting,
        dispatchLogoutAction: () => dispatch(LogoutAction()),
      );
}

// view model
class _ViewModel extends Vm {
  final List<AdvertModel> adverts;
  final void Function() dispatchLogoutAction;
  final bool loading;
  _ViewModel({
    required this.adverts,
    required this.dispatchLogoutAction,
    required this.loading,
  }) : super(equals: [adverts, loading]);
}
