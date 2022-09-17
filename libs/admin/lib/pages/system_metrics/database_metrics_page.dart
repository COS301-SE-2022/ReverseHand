import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/redux_comp.dart';

class DatabaseMetricsPage extends StatelessWidget {
  final Store<AppState> store;
  const DatabaseMetricsPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            return Column();
          },
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, DatabaseMetricsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;

  _ViewModel({
    required this.loading,
  }) : super(equals: [loading]); // implementinf hashcode;
}
