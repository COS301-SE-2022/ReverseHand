import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

class FloatingButtonWidget extends StatelessWidget {
  final void Function() function;
  const FloatingButtonWidget({Key? key, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      vm: () => _Factory(this),
      builder: (BuildContext context, _ViewModel vm) => FloatingActionButton(
        onPressed: function,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, FloatingButtonWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      pushCreateNewAdvert: () => dispatch(
            NavigateAction.pushNamed('/consumer/create_advert'),
          ));
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushCreateNewAdvert;

  _ViewModel({
    required this.pushCreateNewAdvert,
  }); // implementinf hashcode
}
