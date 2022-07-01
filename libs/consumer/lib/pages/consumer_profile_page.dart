import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/navbar.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/bottom_overlay.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/floating_button.dart';

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
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 50.0,
                        ),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        Text(
                          "Luke Skywalker",
                          style: TextStyle(fontSize: 30),
                        ),
                      ]),
                  //********************************************************//

                  //*********PADDING BETWEEN NAME AND OTHER DETAILS********//

                  const Padding(padding: EdgeInsets.all(20)),
                  //**************************************************//

                  //*******************CONSUMER DETAILS************************//

                  Stack(alignment: Alignment.center, children: <Widget>[
                    //overlay
                    BottomOverlayWidget(
                      height: MediaQuery.of(context).size.height / 1.5,
                    ),

                    //location
                    Positioned(
                      top: 40,
                      left: 45,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: Colors.white70,
                            size: 26.0,
                          ),
                          Padding(padding: EdgeInsets.only(left: 8)),
                          Text("Location",
                              style: TextStyle(
                                  fontSize: 26, color: Colors.white70)),
                        ],
                      ),
                    ),

                    const Positioned(
                        top: 80,
                        left: 82,
                        child: Text("Pretoria, Gauteng",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),

                    //cellphone
                    Positioned(
                      top: 140,
                      left: 45,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.phone,
                            color: Colors.white70,
                            size: 26.0,
                          ),
                          Padding(padding: EdgeInsets.only(left: 8)),
                          Text("Cellphone",
                              style: TextStyle(
                                  fontSize: 26, color: Colors.white70)),
                        ],
                      ),
                    ),

                    const Positioned(
                        top: 180,
                        left: 82,
                        child: Text("012 345 6789",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),

                    //email
                    Positioned(
                      top: 240,
                      left: 45,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.email,
                            color: Colors.white70,
                            size: 26.0,
                          ),
                          Padding(padding: EdgeInsets.only(left: 8)),
                          Text("Email",
                              style: TextStyle(
                                  fontSize: 26, color: Colors.white70)),
                        ],
                      ),
                    ),

                    const Positioned(
                        top: 280,
                        left: 82,
                        child: Text("info@gmail.com",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),

                    Positioned(
                      top: 280,
                      right: 35,
                      child: IconButton(
                        onPressed: vm.pushEditProfilePage,
                        icon: const Icon(Icons.edit),
                        color: Colors.white70,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),

          //************************NAVBAR***********************/
          bottomNavigationBar: NavBarWidget(
            store: store,
          ),

          resizeToAvoidBottomInset: false,
          floatingActionButton: const FloatingButtonWidget(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,

          //*************************************************//
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
