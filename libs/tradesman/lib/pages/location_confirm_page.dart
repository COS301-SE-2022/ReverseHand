import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';

import '../widgets/button_bar_widget.dart';
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

                  //**********************StreetNo**********************//
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: ButtonBarTitleWidget(title: "Street No.", value: "221b"),
                  ),
                  //**************************************************//

                   //**********************Street************************//
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: ButtonBarTitleWidget(title: "Street", value: "Baker Street"),
                  ),
                  //**************************************************//

                   //**********************City************************//
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: ButtonBarTitleWidget(title: "City", value: "Centurion"),
                  ),
                  //**************************************************//

                   //**********************Province************************//
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: ButtonBarTitleWidget(title: "Province", value: "Gauteng"),
                  ),
                  //**************************************************//

                  //**********************ZipCode************************//
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
                    child: ButtonBarTitleWidget(title: "Zip Code", value: "0178"),
                  ),
                  //**************************************************//

                 

                  //*******************SAVE BUTTON********************//
                  ButtonWidget(
                      text: "Search Location", function: vm.pushProfilePage),//fix path
                  //**************************************************//

                  const Padding(padding: EdgeInsets.all(8)),

                  //*******************DISCARD BUTTON*****************//
                  ButtonWidget(
                      text: "Discard",
                      color: "dark",
                      function: vm.popPage,
                  ),
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
class _Factory extends VmFactory<AppState, LocationConfirmPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      popPage: () => dispatch(NavigateAction.pop()),
      pushProfilePage: () => dispatch(
            NavigateAction.pushNamed('/tradesman/tradesman_profile_page'),
          ));
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushProfilePage;
  final VoidCallback popPage;

  _ViewModel({
    required this.pushProfilePage, required this.popPage,
  });
}