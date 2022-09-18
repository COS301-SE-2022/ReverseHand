import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

//used in consumer and tradesman

class AppBarWidget extends StatelessWidget {
  final String title;
  final Store<AppState> store;
  final Widget? filterActions;
  final bool? backButton;
  final void Function()? refreshAction;
  const AppBarWidget({
    Key? key,
    required this.title,
    required this.store,
    this.filterActions,
    this.backButton,
    this.refreshAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) => AppBar(
            title: Text(title),
            leadingWidth: 80,
            backgroundColor: Theme.of(context).primaryColorDark,
            leading: Padding(
              padding: const EdgeInsets.only(left: 30),
              // ignore: sized_box_for_whitespace
              child: Container(
                width: 50,
                child: (backButton == true)
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: vm.popPage)
                    : Image.asset(
                        'assets/images/logo.png',
                        package: 'authentication',
                      ),
              ),
            ),
            actions: (filterActions != null)
                ? [filterActions!]
                : (refreshAction != null)
                    ? [
                        Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: IconButton(
                                onPressed: refreshAction,
                                icon: const Icon(Icons.refresh)))
                      ]
                    : [],
          ),
        ));
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, AppBarWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        popPage: () => dispatch(
          NavigateAction.pop(),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;

  _ViewModel({required this.popPage});
}
