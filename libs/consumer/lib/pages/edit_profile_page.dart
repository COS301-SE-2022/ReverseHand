import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/blue_button_widget.dart';
import 'package:general/widgets/profile_button_widget.dart';
import 'package:general/widgets/textfield.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/navbar.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/floating_button.dart';

class EditProfilePage extends StatelessWidget {
  final Store<AppState> store;
  const EditProfilePage({Key? key, required this.store}) : super(key: key);

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
                  const AppBarWidget(title: "Edit Profile"),
                  //***************************************************//

                  //**********************NAME************************//
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: TextFieldWidget(
                      initialVal: "Luke Skywalker",
                      label: "name",
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
                      initialVal: "012 345 6789",
                      label: "cellphone number",
                      obscure: false,
                      controller: null,
                      min: 1,
                    ),
                  ),
                  //**************************************************//

                  /*******************Location Button ****************/

                  ProfileButtonWidget(
                    function: vm.pushLocationConfirmPage, 
                    height: 60, 
                    icon: null, 
                    text: 'Location', 
                    width: 365,
                  ),

                  const Padding(padding: EdgeInsets.only(bottom: 30)),

                  /**************************************************/

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
          floatingActionButton: const FloatingButtonWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,

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
class _Factory extends VmFactory<AppState, EditProfilePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      pushProfilePage: () => dispatch(
            NavigateAction.pushNamed('/consumer/consumer_profile_page'),
          ),
      pushLocationConfirmPage: () => dispatch(
            NavigateAction.pushNamed('/tradesman/location_confirm'),
      ));
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushProfilePage;
  final VoidCallback pushLocationConfirmPage;

  _ViewModel({
    required this.pushProfilePage, required this.pushLocationConfirmPage,
  }); // implementinf hashcode
}
