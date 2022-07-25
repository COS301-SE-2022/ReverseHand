import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/textfield.dart';
import 'package:redux_comp/models/user_models/user_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/profile_button_widget.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';

import '../widgets/navbar.dart';

class EditTradesmanProfilePage extends StatefulWidget {
  final Store<AppState> store;
  const EditTradesmanProfilePage({Key? key, required this.store}) : super(key: key);

  @override
  State<EditTradesmanProfilePage> createState() => _EditTradesmanProfilePageState();
}

class _EditTradesmanProfilePageState extends State<EditTradesmanProfilePage> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
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
                      label: "Name",
                      obscure: false,
                      min: 1,
                      controller: null,
                    ),
                  ),
                  //**************************************************//

                  //********************NUMBER**********************//
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 25),
                    child: TextFieldWidget(
                      label: "Phone",
                      obscure: false,
                      controller: null,
                      min: 1,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 25),
                    child: TextFieldWidget(
                      label: "Domains",
                      obscure: false,
                      controller: null,
                      onTap:
                        vm.pushDomainConfirmPage,
                      min: 1,
                    ),
                  ),
                  //**************************************************//

                  //**********************Domain************************//
                  // ProfileButtonWidget(
                  //   function: vm.pushDomainConfirmPage, 
                  //   height: 60, 
                  //   icon: null, 
                  //   text: 'Domain', 
                  //   width: 365,
                  // ),
                  
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  //**************************************************//

                  //*******************SAVE BUTTON********************//
                  if (vm.userDetails!.registered == true) ...[
                    //*******************SAVE BUTTON********************//
                    ButtonWidget(
                        text: "Save Changes", function: vm.pushProfilePage),
                    //**************************************************//

                    const Padding(padding: EdgeInsets.all(8)),
                    ButtonWidget(
                        text: "Discard",
                        color: "dark",
                        function: vm.pushProfilePage),
                  ] else
                    //*******************SAVE BUTTON********************//
                    ButtonWidget(
                        text: "Save Changes",
                        function: () {
                          // final name = nameController.value.text.trim();
                          // final cell = cellController.value.text.trim();
                          // final location = vm.userDetails!.location;
                          // if (location != null) {
                          //   vm.dispatchCreateConsumerAction(
                          //       name, cell, location);
                          // } else {
                          //   // thinking maybe we can make a generic dispatch error action with an ErrorTpe parameter
                          //   // something like:
                          //   // vm.dispatchError(ErrorType.locationNotCaptured)
                          // }
                        }),
                ],
              ),
            ),
          ),
          //************************NAVBAR***********************/
          bottomNavigationBar: TNavBarWidget(
            store: widget.store,
          ),
          //*****************************************************/
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, _EditTradesmanProfilePageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      pushProfilePage: () => dispatch(
            NavigateAction.pushNamed('/tradesman/profile'),),
      pushDomainConfirmPage: () => dispatch(
            NavigateAction.pushNamed('/tradesman/domain_confirm'),
          ),
      userDetails: (state.userDetails == null) ? null : state.userDetails!,
          );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushProfilePage;
  final VoidCallback pushDomainConfirmPage;
  final UserModel? userDetails;

  _ViewModel({
    required this.pushProfilePage, required this.pushDomainConfirmPage, required this.userDetails,
  }):super(equals: []); 
}
