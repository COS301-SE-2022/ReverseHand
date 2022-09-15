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
              margin: const EdgeInsets.all(10),
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
                          child: Text(report.reportDetails.reportedUser.name,
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
                            Text(report.reportDetails.reason,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black))
                          ],
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
                            Text(report.reportDetails.description,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black))
                          ],
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
        pushReportManagePage: (report) => dispatch(
          NavigateAction.pushNamed("/report_manage", arguments: report),
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
