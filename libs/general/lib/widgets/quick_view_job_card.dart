import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/methods/job_icons.dart';
// import 'package:general/methods/time.dart';
import 'package:redux_comp/actions/bids/view_bids_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/advert_model.dart';

//*********************************************** */
// Job Listings card layout widget
//*********************************************** */

class QuickViewJobCardWidget extends StatelessWidget {
  final AdvertModel advert; // Current advert
  final Store<AppState> store;
  final bool archived;

  const QuickViewJobCardWidget({
    Key? key,
    this.archived = false,
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
          onTap: () => vm.dispatchViewBidsAction(advert, archived),
          child: Card(
            margin: const EdgeInsets.fromLTRB(12, 5, 12, 5),
            color: const Color.fromARGB(255, 232, 232, 232),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 5),
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
                        //*******************ADVERT ICONS******************* */
                        child: Icon(
                          getIcon(advert.type),
                          color: Theme.of(context).primaryColor,
                          size: 32,
                        ),
                      )),
                  //*********************************************** */
                  const Padding(padding: EdgeInsets.all(2)),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.8,
                                  //*******************ADVERT TITLE *************** */
                                  child: Text(advert.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 23,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  //*********************************************** */
                                ),
                              ],
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(bottom: 20),
                            //   child: SizedBox(
                            //     width: 120,
                            //     //*******************ADVERT POST DATE *************** */
                            //     child: Text(
                            //       timestampToDate(advert.dateCreated),
                            //       style: const TextStyle(
                            //         fontSize: 18,
                            //         color: Colors.black54,
                            //       ),
                            //     ),
                            //     //*********************************************** */
                            //   ),
                            // ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 2)),
                        Row(
                          children: [
                            Text(
                              advert.domain.city,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(right: 10)),
                            const Icon(Icons.circle_outlined, size: 8),
                            const Padding(padding: EdgeInsets.only(left: 10)),
                            Text(
                              advert.type,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width / 1.5,
                        //   //*******************ADVERT POST DATE *************** */
                        //   child: Text(
                        //     "Posted ${timestampToDate(advert.dateCreated)}",
                        //     style: const TextStyle(
                        //       fontSize: 18,
                        //       color: Colors.black54,
                        //     ),
                        //   ),
                        //   //*********************************************** */
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
        dispatchViewBidsAction: (AdvertModel ad, bool archived) => dispatch(
          ViewBidsAction(ad: ad, archived: archived),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(AdvertModel, bool) dispatchViewBidsAction;

  _ViewModel({
    required this.dispatchViewBidsAction,
  });
}
