import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/textfield.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/blue_button_widget.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/floating_button.dart';

import '../widgets/navbar.dart';

class EditTradesmanProfilePage extends StatelessWidget {
  final Store<AppState> store;
  const EditTradesmanProfilePage({Key? key, required this.store}) : super(key: key);

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
                  const AppBarWidget(title: "EDIT PROFILE"),
                  //***************************************************//

                  //**********************NAME************************//
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: TextFieldWidget(
                      initialVal: "Luke Skywalker",
                      label: "Name",
                      obscure: false,
                      min: 1,
                      controller: null,
                    ),
                  ),
                  //**************************************************//

                  //********************NUMBER**********************//
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: TextFieldWidget(
                      initialVal: "012 345 6789",
                      label: "Phone",
                      obscure: false,
                      controller: null,
                      min: 1,
                    ),
                  ),
                  //**************************************************//

                  //**********************Domain************************//
                  // Padding( //will have to become button most likely?
                  //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 70),
                  //   child: GestureDetector(
                  //     onTap: vm.pushLocationConfirmPage,
                  //     child: const TextFieldWidget(
                  //     initialVal: "",
                  //     label: "Domain",
                  //     obscure: false,
                  //     controller: null,
                  //     min: 1,
                  //     ),
                  //   ),
                  // ),
                  BlueButtonWidget(
                    function: vm.pushDomainConfirmPage, 
                    height: 65, 
                    icon: null, 
                    text: 'Domain', 
                    width: 365,

                  ),
                  //**************************************************//

                  //*******************SAVE BUTTON********************//
                  ButtonWidget(
                      text: "Save Changes", function: vm.pushProfilePage),
                  //**************************************************//

                  const Padding(padding: EdgeInsets.all(8)),

                  //*******************DISCARD BUTTON*****************//
                  ButtonWidget(
                      text: "Discard",
                      color: "dark",
                      function: vm.pushProfilePage)
                  //**********************NAME************************//
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
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, EditTradesmanProfilePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      pushProfilePage: () => dispatch(
            NavigateAction.pushNamed('/tradesman/tradesman_profile_page'),),
      pushDomainConfirmPage: () => dispatch(
            NavigateAction.pushNamed('/tradesman/domain_confirm'),
          ));
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushProfilePage;
  final VoidCallback pushDomainConfirmPage;

  _ViewModel({
    required this.pushProfilePage, required this.pushDomainConfirmPage,
  }); // implementinf hashcode
}
