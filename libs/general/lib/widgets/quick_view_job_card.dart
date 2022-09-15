import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/methods/job_icons.dart';
import 'package:redux_comp/actions/bids/view_bids_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';

// import '../methods/time.dart';

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
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 7),
            color: const Color.fromARGB(255, 232, 232, 232),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 5),
              child: Row(
                children: [
                  const Padding(padding: EdgeInsets.all(2)),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              width: 2, color: Theme.of(context).primaryColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: Icon(
                          getIcon(advert.type),
                          color: Theme.of(context).primaryColor,
                          size: 35,
                        ),
                      )),
                  const Padding(padding: EdgeInsets.all(2)),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Text(advert.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 2)),
                        Row(
                          children: [
                            Text(advert.domain.city,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            const Padding(padding: EdgeInsets.only(right: 10)),
                            const Icon(Icons.circle_outlined, size: 8),
                            const Padding(padding: EdgeInsets.only(left: 10)),
                            Text(advert.type,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                        // Text(
                        //   "Posted ${timestampToDate(advert.dateCreated)}",
                        //   style: const TextStyle(
                        //     fontSize: 18,
                        //     color: Colors.black54,
                        //   ),
                        // ),
                      ],
                    ),
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
        dispatchViewBidsAction: (String adId) => dispatch(
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
