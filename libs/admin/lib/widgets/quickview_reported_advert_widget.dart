import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
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
          onTap: () => {},
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
                  const Padding(padding: EdgeInsets.all(2)),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Text(advert.advert.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 4)),
                        Row(
                          children: [
                            Text(advert.advert.domain.city,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black)),
                            const Padding(padding: EdgeInsets.only(right: 10)),
                            const Icon(
                              Icons.circle_outlined,
                              size: 8,
                            ),
                            const Padding(padding: EdgeInsets.only(left: 10)),
                            Text(advert.advert.type,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black)),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 8)),
                        Row(
                          children: [
                            const Text("Report count: ",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 18,
                                    color: Colors.black)),
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Text(advert.count.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
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
  _ViewModel fromStore() => _ViewModel();
}

// view model
class _ViewModel extends Vm {
  _ViewModel();
}
