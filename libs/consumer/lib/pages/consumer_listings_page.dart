import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/redux_comp.dart';
import '../methods/populate_adverts.dart';

class ConsumerListingsPage extends StatelessWidget {
  final Store<AppState> store;
  const ConsumerListingsPage({Key? key, required this.store}) : super(key: key);

  //*****Calls method display all active jobs made by a consumer*****//
  @override
  Widget build(BuildContext context) {
    double height = (MediaQuery.of(context).size.height) / 3;

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
                  //*******************PADDING FROM TOP*********************//
                  const Padding(padding: EdgeInsets.only(top: 50)),
                  //********************************************************//

                  // populating column with adverts
                  ...populateAdverts(vm.adverts, store),

                  // button to create a new advert - WILL MOVE TO BOTTOM NAV
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(height / 3),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          onPrimary: Colors.white,
                          shadowColor: Colors.black,
                          elevation: 9,
                          textStyle: const TextStyle(fontSize: 30),
                          minimumSize: const Size(60, 60),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                        ),
                        onPressed: () => vm.pushCreateAdvertPage(),
                        child: const Text("+"), //Look into an icon for demo 3
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //the colour of navigation should change! this does not work yet
          // bottomNavigationBar: BottomNavigationBar(
          //   items: <BottomNavigationBarItem>[
          //     BottomNavigationBarItem(
          //         icon: const Icon(Icons.home),
          //         label: 'Home',
          //         backgroundColor: CustomTheme.darkTheme.primaryColorDark),
          //     const BottomNavigationBarItem(
          //       icon: Icon(Icons.business),
          //       label: 'Business',
          //       backgroundColor: Color.fromARGB(255, 27, 32, 27),
          //     ),
          //     const BottomNavigationBarItem(
          //       icon: Icon(Icons.school),
          //       label: 'School',
          //       backgroundColor: Colors.purple,
          //     ),
          //     const BottomNavigationBarItem(
          //       icon: Icon(Icons.settings),
          //       label: 'Settings',
          //       backgroundColor: Colors.pink,
          //     ),
          //     const BottomNavigationBarItem(
          //       icon: Icon(Icons.settings),
          //       label: 'Settings',
          //       backgroundColor: Colors.pink,
          //     ),
          //   ],
          //   // currentIndex: _selectedIndex,
          //   // selectedItemColor: Colors.amber[800],
          //   // onTap: _onItemTapped,
          // ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ConsumerListingsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        adverts: state.user!.adverts,
        pushCreateAdvertPage: () => dispatch(
          NavigateAction.pushNamed('/consumer/create_advert'),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushCreateAdvertPage;
  final List<AdvertModel> adverts;

  _ViewModel({
    required this.adverts,
    required this.pushCreateAdvertPage,
  }); // implementinf hashcode
}
