import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/user/logout_action.dart';
import 'package:redux_comp/app_state.dart';

class NotificationCardWidget extends StatelessWidget {
  final String titleText;
  final String descText;
  final String date;
  final Store<AppState> store;
  
  const NotificationCardWidget(
      {Key? key,
      required this.titleText,
      required this.descText,
      required this.date,
      required this.store,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(this),
        builder: (BuildContext context, _ViewModel vm) => InkWell(
          onTap: () => {},
          child: Card(
            margin: const EdgeInsets.all(10),
            color: Theme.of(context).primaryColorLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            elevation: 2,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Row(
                children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Row(
                        children: [
                          Text(titleText,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 4, 5, 2),
                            child: Text(date,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white70)),
                          ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                              SizedBox(
                              height: 45,
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(descText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        const TextStyle(fontSize: 20, color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, NotificationCardWidget> {
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
  }); // implementinf hashcode
}
