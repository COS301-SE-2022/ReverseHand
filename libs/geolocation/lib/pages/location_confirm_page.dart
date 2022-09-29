import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:redux_comp/actions/geolocation/set_place_action.dart';
import 'package:redux_comp/models/geolocation/location_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button_bar_widget.dart';
import 'package:general/widgets/long_button_widget.dart';

class LocationConfirmPage extends StatelessWidget {
  final Store<AppState> store;
  const LocationConfirmPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        resizeToAvoidBottomInset:
            false, //prevents floatingActionButton appearing above keyboard
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) => Column(
              children: [
                //*******************APP BAR WIDGET******************//
                AppBarWidget(title: "LOCATION CONFIRM", store: store),
                //***************************************************//

                //**********************StreetNo**********************//
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 30),
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

                LongButtonWidget(
                  text: (vm.userType == "Consumer")
                      ? "Save Location"
                      : "Add Domain",
                  function: vm.dispatchSetPlaceAction,
                ),
                //**************************************************//

                const Padding(padding: EdgeInsets.all(8)),

                //*******************DISCARD BUTTON*****************//
                TransparentLongButtonWidget(
                  text: "Search again",
                  function: vm.pushCustomSearch,
                ),
              ],
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
      dispatchChangePlaceAction: () => dispatch(SetPlaceAction()),
      dispatchSetPlaceAction: () => dispatch(SetPlaceAction()),
      pushCustomSearch: () => dispatch(
            NavigateAction.pushReplacementNamed(
                '/geolocation/custom_location_search',
                arguments: true),
          ),
      popPage: () => dispatch(NavigateAction.pop()),
      location: (state.locationResult == null) ? null : state.locationResult,
      userType: state.userDetails.userType);
}

// view model
class _ViewModel extends Vm {
  final void Function() dispatchChangePlaceAction;
  final void Function() dispatchSetPlaceAction;
  final Location? location;
  final VoidCallback pushCustomSearch;
  final VoidCallback popPage;
  final String userType;

  _ViewModel({
    required this.dispatchChangePlaceAction,
    required this.dispatchSetPlaceAction,
    required this.pushCustomSearch,
    required this.popPage,
    required this.location,
    required this.userType,
  }) : super(equals: [location]);
}
