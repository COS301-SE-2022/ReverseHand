import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

class ChatAppBarWidget extends StatelessWidget {
  final String title;
  final Store<AppState> store;
  const ChatAppBarWidget({Key? key, required this.title, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return StoreProvider<AppState>(
        store: store,
        child: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) => 
          AppBar(
            title: Text(title),
            leadingWidth: 80,
            backgroundColor: Theme.of(context).primaryColorDark,
            leading: StoreConnector<AppState, _ViewModel>(
                  vm: () => _Factory(this),
                  builder: (BuildContext context, _ViewModel vm) => IconButton(
                    onPressed: vm.popPage,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                ),
              ),
          ),
        );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ChatAppBarWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        popPage: () => dispatch(NavigateAction.pop()),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback popPage;

  _ViewModel({
    required this.popPage,
  }); // implementinf hashcode

}
