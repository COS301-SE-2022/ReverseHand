import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:geolocation/pages/location_search_page.dart';
import 'package:redux_comp/models/geolocation/address_model.dart';
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
                        title: "Street No.", value: vm.address.streetNumber),
                  ),
                  //**************************************************//

                  //**********************Street************************//
                  Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                      child: ButtonBarTitleWidget(
                          title: "Street", value: vm.address.street)),
                  //**************************************************//

                  //**********************City************************//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: ButtonBarTitleWidget(
                        title: "City", value: vm.address.city),
                  ),
                  //**************************************************//

                  //**********************Province************************//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: ButtonBarTitleWidget(
                        title: "Province", value: vm.address.province),
                  ),
                  //**************************************************//

                  //**********************ZipCode************************//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: ButtonBarTitleWidget(
                        title: "Zip Code", value: vm.address.zipCode),
                  ),
                  //**************************************************//

                  //*******************SAVE BUTTON********************//
                  ButtonWidget(
                      text: "Add Domain",
                      function: vm.popPage), //fix path
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
      popPage: () => dispatch(NavigateAction.pop()),
      address: state.userDetails!.location!.address);
}

// view model
class _ViewModel extends Vm {
  final Address address;
  final VoidCallback popPage;

  _ViewModel({
    required this.popPage,
    required this.address,
  });
}
