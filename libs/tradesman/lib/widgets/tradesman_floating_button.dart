import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

//used in consumer and tradesman

class TradesmanFloatingButtonWidget extends StatelessWidget {
  final void Function() function;
  const TradesmanFloatingButtonWidget({Key? key, required this.function})
      : super(key: key);

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

class _Factory extends VmFactory<AppState, TradesmanFloatingButtonWidget> {
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
