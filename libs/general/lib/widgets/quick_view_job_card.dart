import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/bids/view_bids_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';

//*********************************************** */
// Job Listings card layout widget
//*********************************************** */

class QuickViewJobCardWidget extends StatelessWidget {
  final AdvertModel advert; // Current advert
  final Store<AppState> store;

  const QuickViewJobCardWidget({
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
          onTap: () => vm.dispatchViewBidsAction(advert.id),
          child: Card(
            margin: const EdgeInsets.all(10),
            // color: Theme.of(context).primaryColorLight,
            color: Colors.white,
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Text(advert.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 30, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 4, 5, 2),
                        child: Text(advert.dateCreated,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white70)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          const Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                          Text(advert.domain.city,
                            style: const TextStyle(
                              fontSize: 20, color: Colors.white))
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
class _Factory extends VmFactory<AppState, QuickViewJobCardWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchViewBidsAction: (adId) => dispatch(
          ViewBidsAction(adId),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(String) dispatchViewBidsAction;

  _ViewModel({
    required this.dispatchViewBidsAction,
  });
}
