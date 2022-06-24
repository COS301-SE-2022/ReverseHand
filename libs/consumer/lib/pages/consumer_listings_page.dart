import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/redux_comp.dart';
import '../methods/populate_adverts.dart';
import 'package:general/widgets/navbar.dart';
import 'package:general/widgets/appbar.dart';

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
              builder: (BuildContext context, _ViewModel vm) => Column(
                children: [
                  //*******************APP BAR WIDGET*********************//
                  const AppBarWidget(title: "Job Listings"),
                  //********************************************************//

                  // populating column with adverts
                  ...populateAdverts(vm.adverts, store),
                ],
              ),
            ),
          ),

          //*******************ADD BUTTON********************//
          floatingActionButton: FloatingActionButton(
            // onPressed: () => vm.pushCreateAdvertPage(), //how to get vm?
            onPressed: () {},
            backgroundColor: Colors.orange,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          //*************************************************//

          //************************NAVBAR***********************/
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
        adverts: state.user!.adverts,
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
