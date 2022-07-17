import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/general.dart';
import 'package:general/widgets/appbar.dart';
import 'package:redux_comp/actions/user/logout_action.dart';
import 'package:redux_comp/redux_comp.dart';

import '../widgets/navbar.dart';

class ActivityStream extends StatelessWidget {
  final Store<AppState> store;
  const ActivityStream({Key? key, required this.store}) : super(key: key);

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
                children: const [
                  //*******************APP BAR WIDGET*********************//
                    AppBarWidget(title: "ACTIVITY STREAM"),
                    //********************************************************//
                ],
              ),
            ),
          ),
           //************************NAVBAR***********************/
          // floatingActionButton: const FloatingButtonWidget(),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,

          bottomNavigationBar: TNavBarWidget(
            store: store,
          ),
          //*****************************************************/
        ),
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, ActivityStream> {
  _Factory(widget) : super(widget);
  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchLogoutAction: () => dispatch(LogoutAction()),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function() dispatchLogoutAction;
  _ViewModel({
    required this.dispatchLogoutAction,
  });
}
