import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/app_state.dart';

//used in consumer and tradesman

class AdminAppBarWidget extends StatelessWidget {
  final String title;
  final Store<AppState> store;
  const AdminAppBarWidget({Key? key, required this.title, required this.store})
      : super(key: key);

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
                child: Image.asset(
                  'assets/images/logo.png',
                  package: 'authentication',
                ),
              ),
            ),
            actions: [
              PopupMenuButton<String>( 
                onSelected: ((item) => true),
                itemBuilder: (BuildContext context) {
                  return {'Filter', ''}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice, style: const TextStyle(color: Colors.black)),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ));
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, AdminAppBarWidget> {
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
