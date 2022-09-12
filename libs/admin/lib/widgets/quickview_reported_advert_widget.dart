import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/actions/admin/set_current_advert_action.dart';
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
          onTap: () => vm.dispatchViewAdvertDetails(advert.advert.id),
          child: Card(
            margin: const EdgeInsets.all(10),
            color: const Color.fromARGB(255, 220, 224, 230),
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
                        padding: const EdgeInsets.all(22),
                        child: Icon(
                          //Painting
                          // Icons.imagesearch_roller,
                          //Tiler
                          //Carpenter
                          // Icons.carpenter,
                          //Cleaner
                          // Icons.sanitizer,
                          //Designer
                          // Icons.design_services,
                          //Landscaper
                          //Electrician
                          // Icons.bolt,
                          //Plumbing
                          Icons.plumbing,
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
                          child: const Text("AdvertTitle",
                              // advert.advert.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),

                        const Padding(padding: EdgeInsets.only(top: 4)),
                        Row(
                          children: const [
                            Text("Randburg",
                                // advert.domain.city,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            Padding(padding: EdgeInsets.only(right: 10)),
                            Icon(
                              Icons.circle_outlined,
                              size: 8,
                            ),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            Text("Painter",
                                // advert.type!,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 3)),
                        Row(
                          children: [
                            const Text("Report count: ",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Theme.of(context).primaryColor),
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                                  child: Text(
                                      // advert.count.toString(),
                                      "5",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                ),
                              ),
                            ),
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
class _Factory extends VmFactory<AppState, QuickViewReportedAdvertCardWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchViewAdvertDetails: (reportId) => dispatch(
          SetCurrentAdvertAction(reportId),
        ),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(String) dispatchViewAdvertDetails;

  _ViewModel({
    required this.dispatchViewAdvertDetails,
  });
}
