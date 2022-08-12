import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

//used in consumer and tradesman

class AppBarWidget extends StatelessWidget {
  final String title;
  final Store<AppState> store;
  const AppBarWidget({Key? key, required this.title, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) => 
          AppBar(
            title: Text(title),
            backgroundColor: Theme.of(context).primaryColorDark,
            leading: IconButton(
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: () {
                vm.pushActivityStreamPage();
              },
              splashRadius: 1,
              highlightColor: Colors.orange,
              splashColor: Colors.white,
            ),
            actions: [
              Container(
                width: 50,
                child: Image.asset( 
                   'assets/images/logo.png',
                    package: 'authentication',
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 10)),
            ],
          ),
        ));
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, AppBarWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        pushActivityStreamPage: () => dispatch(
          NavigateAction.pushNamed('/tradesman/activity_stream'),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushActivityStreamPage;

  _ViewModel({required this.pushActivityStreamPage});
}
