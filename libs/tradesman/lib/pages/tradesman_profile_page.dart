import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/bottom_overlay.dart';

import '../widgets/navbar.dart';

class TradesmanProfilePage extends StatelessWidget {
  final Store<AppState> store;
  const TradesmanProfilePage({Key? key, required this.store}) : super(key: key);

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
                  const AppBarWidget(title: "PROFILE"),
                  //********************************************************//

                  //ALL INFO IS CURRENTLY HARDCODED

                  //*******************CONSUMER NAME************************//
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 50.0,
                    ),
                    const Padding(padding: EdgeInsets.only(right: 10)),
                    Text(
                      store.state.userDetails!.name!,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ]),
                  //********************************************************//

                  const Padding(padding: EdgeInsets.all(20)),

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

                    Positioned(
                        top: 80,
                        left: 82,
                        child: Text(
                            store.state.userDetails!.location!.address.city,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white))),
                    //********************************************************//

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
                          Text("Phone",
                              style: TextStyle(
                                  fontSize: 26, color: Colors.white70)),
                        ],
                      ),
                    ),

                    Positioned(
                        top: 180,
                        left: 82,
                        child: Text(store.state.userDetails!.cellNo!,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white))),
                    //********************************************************//

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

                    Positioned(
                        top: 280,
                        left: 82,
                        child: Text(store.state.userDetails!.email,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white))),
                    //********************************************************//

                    //Trade
                    Positioned(
                      top: 340,
                      left: 45,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.construction_outlined,
                            color: Colors.white70,
                            size: 26.0,
                          ),
                          Padding(padding: EdgeInsets.only(left: 8)),
                          Text("Trade",
                              style: TextStyle(
                                  fontSize: 26, color: Colors.white70)),
                        ],
                      ),
                    ),

                    // //to be integrated by Richard
                    Positioned(
                      top: 380,
                      left: 82,
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ListView(
                          children: vm.tradeTypes
                              .map((element) => Text(element as String,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white)))
                              .toList(),
                        ),
                      ),
                    ),

                    //********************************************************//

                    Positioned(
                      top: 10,
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
          bottomNavigationBar: TNavBarWidget(
            store: store,
          ),

          //*************************************************//
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, TradesmanProfilePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      tradeTypes: state.userDetails!.tradeTypes!,
      pushEditProfilePage: () => dispatch(
            NavigateAction.pushNamed('/tradesman/edit_profile_page'),
          ));
}

// view model
class _ViewModel extends Vm {
  final List<dynamic> tradeTypes;
  final VoidCallback pushEditProfilePage;

  _ViewModel({
    required this.pushEditProfilePage,
    required this.tradeTypes,
  }) : super(equals: [tradeTypes]);
}
