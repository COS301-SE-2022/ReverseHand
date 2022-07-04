import 'package:flutter/material.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:async_redux/async_redux.dart';

//stateless?

// class NavBarWidget extends StatefulWidget {
//   final Store<AppState> store;
//   const NavBarWidget({Key? key, required this.store}) : super(key: key);

//   @override
//   State<NavBarWidget> createState() => _NavBarWidgetState();
// }

class NavBarWidget extends StatelessWidget {
  final Store<AppState> store;
  const NavBarWidget({Key? key, required this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //general shape and shadows
    return StoreProvider<AppState>(
      store: store,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),

        //extra clipping off edges
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),

          //bottom nav functionality
          child: BottomAppBar(
              color: Theme.of(context).primaryColorDark,
              shape: const CircularNotchedRectangle(),
              notchMargin: 5,
              child: StoreConnector<AppState, _ViewModel>(
                  vm: () => _Factory(this),
                  builder: (BuildContext context, _ViewModel vm) => Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          //icon 1 - Consumer Listings
                          IconButton(
                            icon: const Icon(
                              Icons.work,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              vm.pushConsumerListings();
                            },
                            splashRadius: 30,
                            highlightColor: Colors.orange,
                            splashColor: Colors.white,
                          ),

                          //icon 2 - chat
                          IconButton(
                            icon: const Icon(
                              Icons.forum,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                            splashRadius: 30,
                            highlightColor: Colors.orange,
                            splashColor: Colors.white,
                          ),

                          //icon 3 - profile
                          IconButton(
                            icon: const Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              vm.pushProfilePage();
                            },
                            splashRadius: 30,
                            highlightColor: Colors.orange,
                            splashColor: Colors.white,
                          ),

                          //icon 4 - log out ?
                          IconButton(
                            icon: const Icon(
                              Icons.logout,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                            splashRadius: 30,
                            highlightColor: Colors.orange,
                            splashColor: Colors.white,
                          ),
                        ],
                      ))),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, NavBarWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        pushProfilePage: () => dispatch(
          NavigateAction.pushNamed('/consumer/consumer_profile_page'),
        ),
        pushConsumerListings: () => dispatch(
          NavigateAction.pushNamed('/consumer'),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushProfilePage;
  final VoidCallback pushConsumerListings;

  _ViewModel(
      {required this.pushProfilePage, required this.pushConsumerListings});
}
