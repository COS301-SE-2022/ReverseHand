import 'package:flutter/material.dart';
import 'package:redux_comp/actions/admin/get_reported_adverts_action.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:async_redux/async_redux.dart';

//******************************** */
//  navbar for tradesman
//******************************** */

class AdminNavBarWidget extends StatelessWidget {
  final Store<AppState> store;
  const AdminNavBarWidget({Key? key, required this.store}) : super(key: key);
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
              spreadRadius: 3,
              blurRadius: 8,
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
                          //icon 1 - Advert Reports
                          IconButton(
                            icon: const Text(
                              "M",
                              style: TextStyle(fontSize: 25),
                            ),
                            onPressed: () {
                              vm.pushAppMetrics();
                            },
                            splashRadius: 30,
                            highlightColor: Colors.orange,
                            splashColor: Colors.white,
                          ),

                          //icon 2 - chat
                          IconButton(
                            icon: const Text(
                              "U",
                              style: TextStyle(fontSize: 25),
                            ),
                            onPressed: () {
                              vm.pushUserManage();
                            },
                            splashRadius: 30,
                            highlightColor: Colors.orange,
                            splashColor: Colors.white,
                          ),

                          //icon 3 - activity stream
                          IconButton(
                            icon: const Text(
                              "C",
                              style: TextStyle(fontSize: 25),
                            ),
                            onPressed: () => vm.pushContentManage(),
                            splashRadius: 30,
                            highlightColor: Colors.orange,
                            splashColor: Colors.white,
                          ),

                          //icon 4 - profile
                          IconButton(
                            icon: const Text(
                              "?",
                              style: TextStyle(fontSize: 25),
                            ),
                            onPressed: () {
                              vm.pushProfilePage();
                            },
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
class _Factory extends VmFactory<AppState, AdminNavBarWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        pushAppMetrics: () => dispatch(
          NavigateAction.pushNamedAndRemoveUntil(
              '/admin_metrics', ModalRoute.withName('/')),
        ),
        pushUserManage: () => dispatch(
          NavigateAction.pushNamedAndRemoveUntil(
              '/admin_users', ModalRoute.withName('/')),
        ),
        pushContentManage: () {
          dispatch(GetReportedAdvertsAction(state.userDetails!.scope!));
          dispatch(NavigateAction.pushNamedAndRemoveUntil(
              '/admin_content', ModalRoute.withName('/')));
        },
        pushProfilePage: () => dispatch(
          NavigateAction.pushNamedAndRemoveUntil(
              '/admin_metrics', ModalRoute.withName('/')),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushAppMetrics;
  final VoidCallback pushUserManage;
  final VoidCallback pushContentManage;
  final VoidCallback pushProfilePage;

  _ViewModel({
    required this.pushAppMetrics,
    required this.pushUserManage,
    required this.pushContentManage,
    required this.pushProfilePage,
  });
}
