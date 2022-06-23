import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/navbar.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/bottom_overlay.dart';
import 'package:general/widgets/button.dart';

class ConsumerProfilePage extends StatelessWidget {
  final Store<AppState> store;
  const ConsumerProfilePage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: CustomTheme.darkTheme,
        home: Scaffold(
          body: SingleChildScrollView(
            child: StoreConnector<AppState, _ViewModel>(
              vm: () => _Factory(this),
              builder: (BuildContext context, _ViewModel vm) => Column(
                children: [
                  //*******************APP BAR WIDGET*********************//

                  const AppBarWidget(title: "Profile"),
                  //********************************************************//

                  //*******************CONSUMER NAME************************//

                  const Text(
                    "Luke Skywalker",
                    style: TextStyle(fontSize: 30),
                  ),
                  //********************************************************//

                  //*********PADDING BETWEEN NAME AND OTHER DETAILS********//

                  const Padding(padding: EdgeInsets.all(20)),
                  //**************************************************//

                  Stack(children: <Widget>[
                    //*******************CONSUMER DETAILS************************//
                    BottomOverlayWidget(
                      height: MediaQuery.of(context).size.height / 1.5,
                    ),

                    //location
                    const Positioned(
                      top: 20,
                      left: 70,
                      child: Text("Location",
                          style:
                              TextStyle(fontSize: 20, color: Colors.white70)),
                    ),
                    Positioned(
                      top: 45,
                      left: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          Padding(padding: EdgeInsets.only(right: 4)),
                          Text("Pretoria, Gauteng",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white))
                        ],
                      ),
                    ),

                    //email
                    const Positioned(
                      top: 90,
                      left: 70,
                      child: Text("Email",
                          style:
                              TextStyle(fontSize: 20, color: Colors.white70)),
                    ),
                    Positioned(
                      top: 115,
                      left: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.email,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          Padding(padding: EdgeInsets.only(right: 4)),
                          Text("info@gmail.com",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white))
                        ],
                      ),
                    ),

                    //cellphone
                    const Positioned(
                      top: 160,
                      left: 70,
                      child: Text("Cellphone",
                          style:
                              TextStyle(fontSize: 20, color: Colors.white70)),
                    ),
                    Positioned(
                      top: 185,
                      left: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          Padding(padding: EdgeInsets.only(right: 4)),
                          Text("012 345 6789",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white))
                        ],
                      ),
                    ),
                    Positioned(
                      top: 250,
                      right: 40,
                      child: ButtonWidget(
                          text: "Edit",
                          function: vm
                              .pushEditProfilePage //this is not the correct path yet
                          ),
                    )
                    //********************************************************//
                  ]),
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
          //*************************************************//

          //************************NAVBAR***********************/
          bottomNavigationBar: const NavBarWidget(),
          //*****************************************************/
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ConsumerProfilePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      pushEditProfilePage: () => dispatch(
            NavigateAction.pushNamed('/consumer/edit_profile_page'),
          ));
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushEditProfilePage;

  _ViewModel({
    required this.pushEditProfilePage,
  }); // implementinf hashcode
}
