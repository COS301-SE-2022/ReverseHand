import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
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
                  const AppBarWidget(title: "EDIT PROFILE"),
                  //***************************************************//

                  //**********************NAME************************//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: TextFieldWidget(
                      initialVal: store.state.user!.name,
                      label: "name",
                      obscure: false,
                      min: 1,
                      controller: null,
                    ),
                  ),
                  //**************************************************//

                  //********************NUMBER**********************//
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: TextFieldWidget(
                      initialVal: store.state.user!.cellNo,
                      label: "cellphone number",
                      obscure: false,
                      controller: null,
                      min: 1,
                    ),
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
          ));
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushProfilePage;

  _ViewModel({
    required this.pushProfilePage,
  }); // implementinf hashcode
}
