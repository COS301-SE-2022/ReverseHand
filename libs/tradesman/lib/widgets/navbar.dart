import 'package:flutter/material.dart';
import 'package:redux_comp/actions/user/logout_action.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:async_redux/async_redux.dart';
import 'package:redux_comp/actions/chat/get_chats_action.dart';

//stateless?

// class NavBarWidget extends StatefulWidget {
//   final Store<AppState> store;
//   const NavBarWidget({Key? key, required this.store}) : super(key: key);

//   @override
//   State<NavBarWidget> createState() => _NavBarWidgetState();
// }

class TNavBarWidget extends StatelessWidget {
  final Store<AppState> store;
  const TNavBarWidget({Key? key, required this.store}) : super(key: key);
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
              spreadRadius: 3,
              blurRadius: 8,
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
                              vm.pushTradesmanListings();
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
                            onPressed: () {
                              vm.dispatchGetChatsAction();
                              vm.pushChatPage();
                            },
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
                            onPressed: () => vm.dispatchLogoutAction(),
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
class _Factory extends VmFactory<AppState, TNavBarWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        pushProfilePage: () => dispatch(
          NavigateAction.pushNamed('/tradesman/profile'),
        ),
        pushActivityStreamPage: () => dispatch(
          NavigateAction.pushNamed('/tradesman/activity_stream'),
        ),
        pushTradesmanListings: () => dispatch(
          NavigateAction.pushNamed('/tradesman'),
        ),
        dispatchLogoutAction: () => dispatch(LogoutAction()),
        pushChatPage: () => dispatch(
          NavigateAction.pushNamed('/chats'),
        ),
        dispatchGetChatsAction: () => dispatch(GetChatsAction()),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushProfilePage;
  final VoidCallback pushActivityStreamPage;
  final VoidCallback pushTradesmanListings;
  final void Function() dispatchLogoutAction;
  final VoidCallback pushChatPage;
  final void Function() dispatchGetChatsAction;

  _ViewModel(
      {required this.pushProfilePage, 
      required this.pushActivityStreamPage, 
      required this.pushTradesmanListings,
      required this.dispatchLogoutAction,
      required this.pushChatPage,
      required this.dispatchGetChatsAction,
      });
}
