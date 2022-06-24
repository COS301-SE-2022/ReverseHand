import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/textfield.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/navbar.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/bottom_overlay.dart';
import 'package:general/widgets/button.dart';

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
                  //*******************APP BAR WIDGET*********************//

                  const AppBarWidget(title: "Edit Profile"),
                  //********************************************************//

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

                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: TextFieldWidget(
                      initialVal: "012 345 6789",
                      label: "cellphone number",
                      obscure: false,
                      controller: null,
                      min: 1,
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 70),
                    child: TextFieldWidget(
                      initialVal: "info@gmail.com",
                      label: "email",
                      obscure: false,
                      controller: null,
                      min: 1,
                    ),
                  ),

                  ButtonWidget(
                      text: "SAVE CHANGES", function: vm.pushProfilePage),
                  const Padding(padding: EdgeInsets.all(8)),
                  ButtonWidget(
                      text: "DISCARD",
                      transparent: true,
                      function: vm.pushProfilePage)
                ],
              ),
            ),
          ),
          //*******************ADD BUTTON********************//
          floatingActionButton: FloatingActionButton(
            // onPressed: () => vm.pushCreateAdvertPage(), //how to get vm?
            onPressed: () {},
            backgroundColor: Colors.orange,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          //*****************************************************/

          //************************NAVBAR***********************/
          bottomNavigationBar: const NavBarWidget(),
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
