import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux_comp/models/admin/app_management/report_model.dart';
import 'package:redux_comp/redux_comp.dart';

class QuickviewReportWidget extends StatelessWidget {
  final Store<AppState> store;
  final ReportModel report;
  const QuickviewReportWidget(
      {Key? key, required this.store, required this.report})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(this),
        builder: (BuildContext context, _ViewModel vm) {
          return InkWell(
            onTap: () => vm.pushReportManagePage(report),
            child: Card(
              margin: const EdgeInsets.all(12),
              color: const Color.fromARGB(255, 232, 232, 232),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              elevation: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.list,
                              size: 23,
                              color: Theme.of(context).primaryColor,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 5)),
                            const Text("Report reason: ",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(report.reportDetails.reason,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black)),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Row(
                          children: [
                            Icon(
                              Icons.description_outlined,
                              size: 23,
                              color: Theme.of(context).primaryColor,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 5)),
                            const Text("Report description: ",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(report.reportDetails.description,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, QuickviewReportWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        pushReportManagePage: (report) => (report.type == "user#reports")
            ? dispatch(
                NavigateAction.pushNamed("/report_manage", arguments: report),
              )
            : dispatch(
                NavigateAction.pushNamed("/review_report_manage",
                    arguments: report),
              ),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(ReportModel) pushReportManagePage;

  _ViewModel({
    required this.pushReportManagePage,
  });
}
