import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:redux_comp/actions/user/logout_action.dart';
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
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) => Column(
              children: [
                //*******************APP BAR WIDGET*********************//
                Stack(children: [
                  AppBarWidget(title: "JOB LISTINGS", store: store),
                  //********************************************************//
                  Positioned(
                    top: 110,
                    right: 20,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).scaffoldBackgroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor))),
                      onPressed: () {
                        DarkDialogHelper.display(
                          context,
                          FilterPopUpWidget(
                            store: store,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.filter_alt,
                        size: 25,
                      ),
                      label: const Text(
                        "Filter",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ]),
                ...populateAdverts(vm.adverts, store),

                if (vm.loading)
                  const LoadingWidget()

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
    );
  }
}

class _Factory extends VmFactory<AppState, TradesmanJobListings> {
  _Factory(widget) : super(widget);
  @override
  _ViewModel fromStore() => _ViewModel(
        adverts: state.viewAdverts,
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
