import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/floating_button.dart';
import 'package:geolocation/pages/custom_location_search_page.dart';
import 'package:geolocation/pages/location_search_page.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:tradesman/methods/populate_domains.dart';
import 'package:uuid/uuid.dart';

class DomainConfirmPage extends StatelessWidget {
  final Store<AppState> store;
  const DomainConfirmPage({Key? key, required this.store}) : super(key: key);

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
                  const AppBarWidget(title: "DOMAINS DISPLAY"),
                  //***************************************************//

                  //**************** Domain Location Cards*************//
                  // CardWidget(store: store, title: 'Pretoria'),
                  // CardWidget(store: store, title: 'Centurion'),
                  ...populateDomains(store, vm.domains),
                  //***************************************************//

                  //dynamic save button
                  if (vm.domains.isNotEmpty)
                    const Padding(padding: EdgeInsets.all(8)),

                  //*******************DISCARD BUTTON*****************//
                  ButtonWidget(text: "Back", color: "dark", function: vm.pop)
                  //**********************NAME************************//
                ],
              ),
            ),
          ),
          //************************NAVBAR***********************/
          floatingActionButton: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) =>
                FloatingButtonWidget(
              function: () async {
                final sessionToken = const Uuid().v1();  
                // ignore: unused_local_variable
                // final result = await showSearch(
                //     context: context,
                //     delegate: LocationSearchPage(sessionToken, store)
                //     );

              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          // bottomNavigationBar: TNavBarWidget(
          //   store: store,
          // ),
          //*****************************************************/
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, DomainConfirmPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        domains: state.userDetails!.domains,
        pop: () => dispatch(
          NavigateAction.pop(),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pop;
  final List<Domain> domains;

  _ViewModel({
    required this.domains,
    required this.pop,
  }) : super(equals: [domains]);
}
