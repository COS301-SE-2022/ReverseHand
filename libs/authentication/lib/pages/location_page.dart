import 'package:async_redux/async_redux.dart';
import 'package:authentication/pages/location_search_page.dart';
import 'package:flutter/material.dart';
import 'package:general/theme.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/geolocation/address_model.dart';
import 'package:uuid/uuid.dart';

class LocationPage extends StatelessWidget {
  final Store<AppState> store;
  final Address? result;

  const LocationPage({Key? key, required this.store, this.result})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: Scaffold(
          body: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) => Column(
              children: [
                //**********APPBAR***********//
                const AppBarWidget(title: "Location Search"),

                const Padding(padding: EdgeInsets.only(top: 50)),


                ButtonWidget(
                    text: "Search your location",
                    color: "light",
                    function: () {
                      final sessionToken = const Uuid().v1();
                      showSearch(
                          context: context,
                          delegate: LocationSearchPage(sessionToken, store));
                    }),

                //Back
                ButtonWidget(
                    text: "Back",
                    color: "light",
                    whiteBorder: true,
                    function: vm.popPage)
              ],
            ),
          ),
        ),
      ),
    ); //*******************************************/
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, LocationPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        popPage: () => dispatch(NavigateAction.pop()),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;
  _ViewModel({required this.popPage}); // implementinf hashcode
}
