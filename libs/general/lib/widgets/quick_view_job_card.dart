import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
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

  IconData jobType() {
    switch (advert.type) {
      case "Painting":
        return Icons.imagesearch_roller;
      case "Tiler":
        return Icons.imagesearch_roller;
      case "Carpenter":
        return Icons.carpenter;
      case "Cleaner":
        return Icons.sanitizer;
      case "Designer":
        return Icons.design_services;
      case "Landscaper":
        return Icons.imagesearch_roller;
      case "Electrician":
        return Icons.bolt;
      case "Plumbing":
        return Icons.plumbing;
      default:
        return Icons.plumbing;
    }
  }

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
                          jobType(),
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
                                  fontSize: 28,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 4)),
                        Row(
                          children: [
                            Text(advert.domain.city,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            const Padding(padding: EdgeInsets.only(right: 10)),
                            const Icon(Icons.circle_outlined, size: 8),
                            const Padding(padding: EdgeInsets.only(left: 10)),
                            Text(advert.type!,
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
