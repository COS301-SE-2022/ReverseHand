import 'package:flutter/material.dart';
import 'package:redux_comp/actions/adverts/view_adverts_action.dart';
import 'package:redux_comp/actions/analytics_events/record_create_advert_action.dart';
import 'package:redux_comp/actions/user/amplify_auth/logout_action.dart';
import 'package:redux_comp/actions/chat/get_chats_action.dart';
import 'package:redux_comp/actions/user/get_notifications_action.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:async_redux/async_redux.dart';

//the consumer navbar

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
              topRight: Radius.circular(20), topLeft: Radius.circular(15)),
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
            topLeft: Radius.circular(7.0),
            topRight: Radius.circular(7.0),
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
                      vm.dispatchViewAdvertsAction();
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
                    onPressed: () {
                      vm.dispatchGetChatsAction();
                      vm.pushChatPage();
                    },
                    splashRadius: 30,
                    highlightColor: Colors.orange,
                    splashColor: Colors.white,
                  ),

                  //icon 3 - activity stream
                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      vm.dispatchGetNotificationsAction();
                      vm.pushActivityStreamPage();
                    },
                    splashRadius: 30,
                    highlightColor: Colors.orange,
                    splashColor: Colors.white,
                  ),

                  //icon 4 - profile
                  IconButton(
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // vm.pushProfilePage();
                      vm.test('Pretoria', 'Gauteng');
                    },
                    splashRadius: 30,
                    highlightColor: Colors.orange,
                    splashColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
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
          NavigateAction.pushReplacementNamed(
              '/consumer/consumer_profile_page'),
        ),
        pushConsumerListings: () => dispatch(
          NavigateAction.pushReplacementNamed('/consumer'),
        ),
        pushChatPage: () => dispatch(
          NavigateAction.pushReplacementNamed('/chats'),
        ),
        pushActivityStreamPage: () => dispatch(
          NavigateAction.pushReplacementNamed('/general/activity_stream'),
        ),
        dispatchLogoutAction: () => dispatch(LogoutAction()),
        dispatchGetChatsAction: () => dispatch(GetChatsAction()),
        dispatchGetNotificationsAction: () =>
            dispatch(GetNotificationsAction()),
        dispatchViewAdvertsAction: () => dispatch(ViewAdvertsAction()),
        test: (p0, p1) =>
            dispatch(RecordCreateAdvertAction(city: p0, province: p1)),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushProfilePage;
  final VoidCallback pushConsumerListings;
  final VoidCallback pushChatPage;
  final VoidCallback pushActivityStreamPage;
  final VoidCallback dispatchLogoutAction;
  final VoidCallback dispatchGetChatsAction;
  final VoidCallback dispatchGetNotificationsAction;
  final VoidCallback dispatchViewAdvertsAction;
  final void Function(String, String) test;

  _ViewModel({
    required this.pushProfilePage,
    required this.pushChatPage,
    required this.test,
    required this.dispatchViewAdvertsAction,
    required this.dispatchGetChatsAction,
    required this.pushConsumerListings,
    required this.dispatchLogoutAction,
    required this.pushActivityStreamPage,
    required this.dispatchGetNotificationsAction,
  });
}
