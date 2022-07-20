import 'package:async_redux/async_redux.dart';

import 'package:flutter/material.dart';
import 'package:general/general.dart';

import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/redux_comp.dart';
import '../methods/populate_adverts.dart';
import 'package:general/widgets/navbar.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/floating_button.dart';

class ConsumerListingsPage extends StatelessWidget {
  final Store<AppState> store;
  bool isLoading = false;
  ConsumerListingsPage({Key? key, required this.store}) : super(key: key);

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
              builder: (BuildContext context, _ViewModel vm) => Column(
                children: [
                  //*******************APP BAR WIDGET*********************//
                  const AppBarWidget(title: "MY JOBS"),
                  //********************************************************//

                  // populating column with adverts
                  ...populateAdverts(vm.adverts, store),

                  //************MESSAGE IF THERE ARE NO ADVERTS***********/
                  if (vm.adverts.isEmpty)
                    (Padding(
                      padding: EdgeInsets.only(
                          top: (MediaQuery.of(context).size.height) / 3),
                      child: const Text(
                        "There are no\n active jobs",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25, color: Colors.white54),
                      ),
                    )),
                  //*****************************************************/
                ],
              ),
            ),
          ),

          //************************NAVBAR***********************/
          floatingActionButton: const FloatingButtonWidget(),
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

  _ViewModel({
    required this.adverts,
    required this.pushCreateAdvertPage,
  }); // implementinf hashcode

}
