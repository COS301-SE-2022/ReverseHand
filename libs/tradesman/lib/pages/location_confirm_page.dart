import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/textfield.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/floating_button.dart';

import '../widgets/navbar.dart';

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

                  //**********************StreetNo************************//
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: Text(
                      "StreetNo",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  //**************************************************//

                   //**********************Street************************//
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: Text(
                      "Street",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  //**************************************************//

                   //**********************City************************//
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: Text(
                      "City",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  //**************************************************//

                   //**********************Province************************//
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: Text(
                      "Province",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  //**************************************************//

                  //**********************ZipCode************************//
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: Text(
                      "Zip Code",
                      style: TextStyle(fontSize: 20),
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
class _Factory extends VmFactory<AppState, LocationConfirmPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      pushProfilePage: () => dispatch(
            NavigateAction.pushNamed('/tradesman/tradesman_profile_page'),
          ));
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushProfilePage;

  _ViewModel({
    required this.pushProfilePage,
  }); // implementinf hashcode
}
