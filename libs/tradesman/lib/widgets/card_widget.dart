import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:async_redux/async_redux.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final Store<AppState> store;

  const CardWidget({
    Key? key,
    required this.store,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //general shape and shadows
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(this),
        builder: (BuildContext context, _ViewModel vm) => Column(
          children: [
            Card(
              margin: const EdgeInsets.all(10),
              color: Theme.of(context).primaryColorLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(title,
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white)),
                    ButtonWidget(
                      text: "Delete",
                      color: "light",
                      function: vm.pushLocationConfirmPage,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, CardWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      pushLocationConfirmPage: () => dispatch(
            NavigateAction.pushNamed('/tradesman/location_confirm'),
          ));
}

// view model
class _ViewModel extends Vm {
  final VoidCallback pushLocationConfirmPage;

  _ViewModel({
    required this.pushLocationConfirmPage,
  });
}
