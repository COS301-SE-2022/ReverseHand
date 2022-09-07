import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/redux_comp.dart';

//this makes the dynamic popup menu in the admin app bar, 
//yes... popup menu would've been a better name

class AdminAppbarUserActionsWidget extends StatelessWidget {
  final Store<AppState> store;
  final Map<String, VoidCallback> functions;
  const AdminAppbarUserActionsWidget(
      {Key? key, required this.store, required this.functions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(this),
        builder: (BuildContext context, _ViewModel vm) =>
            PopupMenuButton<String>(
          onSelected: (item) => functions[item]!(),
          itemBuilder: (BuildContext context) {
            List<PopupMenuEntry<String>> result = [];
            functions.forEach((choice, selected) {
              result.add(
                PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black)),
                ),
              );
            });
            return result;
          },
        ),
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, AdminAppbarUserActionsWidget> {
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
