 import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/admin/set_current_user_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/admin/reported_advert_model.dart';

//*********************************************** */
// Reported Advert card layout widget
//*********************************************** */

class QuickViewReportedAdvertCardWidget extends StatelessWidget {
  final ReportedAdvertModel advert; // Current user
  final Store<AppState> store;

  const QuickViewReportedAdvertCardWidget({
    Key? key,
    required this.advert,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(this),
        builder: (BuildContext context, _ViewModel vm) => InkWell(
          onTap: () {},
          child: Card(
            margin: const EdgeInsets.all(10),
            // color: Theme.of(context).primaryColorLight,
            color: const Color.fromARGB(255, 220, 224, 230),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            elevation: 2,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Text(advert.advert.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 30, color: Colors.black)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.numbers,
                            color: Colors.black,
                            size: 25.0,
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                          Text(advert.count.toString(),
                            style: const TextStyle(
                              fontSize: 20, color: Colors.black))
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(150, 4, 5, 2),
                        child: Text("Warning: 5",
                            style: TextStyle(
                                fontSize: 18, color: Color.fromARGB(255, 70, 70, 70))),
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
class _Factory extends VmFactory<AppState, QuickViewReportedAdvertCardWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchViewProfileAction: (userId) => dispatch(
          SetCurrentUserAction(userId),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(String) dispatchViewProfileAction;

  _ViewModel({
    required this.dispatchViewProfileAction,
  });
}
