import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/bids/view_bids_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';

import '../methods/time.dart';

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
            margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            //experimenting with colours currenlty
            // color: Theme.of(context).primaryColorLight,
            // color: const Color.fromARGB(255, 220, 224, 230),
            color: const Color.fromARGB(255, 232, 232, 232),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            elevation: 2,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 11.0, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Text(advert.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(fontSize: 30, color: Colors.black)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3, 5, 5, 2),
                    child: Text(
                      timestampToDate(advert.dateCreated),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.black,
                            size: 25.0,
                          ),
                          Text(advert.domain.city,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black)),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          //MICHAEL
                          //   "Posted: ${advert.dateCreated}",
                          "Posted: 16/08",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 70, 70, 70)),
                          maxLines: 1,
                        ),
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
