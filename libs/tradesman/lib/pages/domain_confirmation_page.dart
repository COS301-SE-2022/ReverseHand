import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/floating_button.dart';
import 'package:tradesman/widgets/card_widget.dart';

import '../widgets/navbar.dart';

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
                  CardWidget(store: store, title: 'Pretoria'),
                  CardWidget(store: store, title: 'Centurion'),
                  //***************************************************//

                  const Padding(padding: EdgeInsets.all(8)),

                  //*******************DISCARD BUTTON*****************//
                  ButtonWidget(
                      text: "Back",
                      color: "dark",
                      function: vm.pop)
                  //**********************NAME************************//
                ],
              ),
            ),
          ),
          //************************NAVBAR***********************/
          floatingActionButton: const FloatingButtonWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,

          bottomNavigationBar: TNavBarWidget(
            store: store,
          ),
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
      pop: () => dispatch(
            NavigateAction.pop(),
          ));
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pop;

  _ViewModel({
    required this.pop,
  }); 
}
