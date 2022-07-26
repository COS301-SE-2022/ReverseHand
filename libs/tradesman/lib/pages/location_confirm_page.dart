import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:geolocation/pages/location_search_page.dart';
import 'package:redux_comp/actions/geolocation/set_place_action.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:uuid/uuid.dart';

import '../widgets/button_bar_widget.dart';

class LocationConfirmPage extends StatelessWidget {
  final Store<AppState> store;
  const LocationConfirmPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: Scaffold(
          resizeToAvoidBottomInset:
              false, //prevents floatingActionButton appearing above keyboard
          body: SingleChildScrollView(
            child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) => Column(
                children: [
                  //*******************APP BAR WIDGET******************//
                  const AppBarWidget(title: "LOCATION CONFIRM"),
                  //***************************************************//

                  //**********************StreetNo**********************//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: ButtonBarTitleWidget(
                        title: "Street No.",
                        value: (vm.location != null)
                            ? vm.location!.address.streetNumber
                            : "null"),
                  ),
                  //**************************************************//

                  //**********************Street************************//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: ButtonBarTitleWidget(
                        title: "Street",
                        value: (vm.location != null)
                            ? vm.location!.address.street
                            : "null"),
                  ),
                  //**************************************************//

                  //**********************City************************//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: ButtonBarTitleWidget(
                        title: "City",
                        value: (vm.location != null)
                            ? vm.location!.address.city
                            : "null"),
                  ),
                  //**************************************************//

                  //**********************Province************************//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: ButtonBarTitleWidget(
                        title: "Province",
                        value: (vm.location != null)
                            ? vm.location!.address.province
                            : "null"),
                  ),
                  //**************************************************//

                  //**********************ZipCode************************//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: ButtonBarTitleWidget(
                        title: "Zip Code",
                        value: (vm.location != null)
                            ? vm.location!.address.zipCode
                            : "null"),
                  ),
                  //**************************************************//

                  //*******************SAVE BUTTON********************//
                  ButtonWidget(
                    text: "Add Domain",
                    function: vm.dispatchSetPlaceAction, 
                  ),
                  //**************************************************//

                  const Padding(padding: EdgeInsets.all(8)),

                  //*******************DISCARD BUTTON*****************//
                  ButtonWidget(
                    text: "Search again",
                    color: "dark",
                    function: () {
                      final sessionToken = const Uuid().v1();
                      vm.popPage();
                      showSearch(
                          context: context,
                          delegate: LocationSearchPage(sessionToken, store));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, LocationConfirmPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchSetPlaceAction: () => dispatch(SetPlaceAction()),
        popPage: () => dispatch(NavigateAction.pop()),
        location: (state.locationResult == null) ? null : state.locationResult,
      );
}

// view model
class _ViewModel extends Vm {
  final void Function() dispatchSetPlaceAction;
  final Location? location;
  final VoidCallback popPage;

  _ViewModel({
    required this.dispatchSetPlaceAction,
    required this.popPage,
    required this.location,
  }) : super(equals: [location]);
}
