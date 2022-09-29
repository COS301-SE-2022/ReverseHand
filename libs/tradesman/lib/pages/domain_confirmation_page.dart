import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:tradesman/widgets/tradesman_floating_button.dart';
import 'package:redux_comp/models/geolocation/domain_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/appbar.dart';
import 'package:tradesman/methods/populate_domains.dart';

class DomainConfirmPage extends StatelessWidget {
  final Store<AppState> store;
  const DomainConfirmPage({Key? key, required this.store}) : super(key: key);

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
                AppBarWidget(title: "MY DOMAINS", store: store, backButton: true,),
                //***************************************************//

                //**************** Domain Location Cards*************//
                const Padding(padding: EdgeInsets.only(top: 15)),
                ...populateDomains(store, vm.domains),
                //***************************************************//

                //dynamic save button
                if (vm.domains.isNotEmpty)
                  const Padding(padding: EdgeInsets.all(8)),

                //**********************NAME************************//
              ],
            ),
          ),
        ),
        //************************NAVBAR***********************/
        floatingActionButton: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) => Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: TradesmanFloatingButtonWidget(
              function: vm.pushCustomSearch,
              type: "add",
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // bottomNavigationBar: TNavBarWidget(
        //   store: store,
        // ),
        //*****************************************************/
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, DomainConfirmPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        pushCustomSearch: () => dispatch(
          NavigateAction.pushNamed('/geolocation/custom_location_search',
              arguments: true),
        ),
        domains: state.userDetails.domains,
        pop: () => dispatch(
          NavigateAction.pop(),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushCustomSearch;
  final VoidCallback pop;
  final List<Domain> domains;

  _ViewModel({
    required this.pushCustomSearch,
    required this.domains,
    required this.pop,
  }) : super(equals: [domains]);
}
