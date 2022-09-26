import 'package:admin/widgets/quickview_reported_advert_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/list_refresh_widget.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/admin/app_management/get_reported_adverts_action.dart';
import 'package:redux_comp/models/admin/app_management/reported_advert_model.dart';
import 'package:redux_comp/redux_comp.dart';

class ViewAdvertReportsPage extends StatelessWidget {
  final Store<AppState> store;

  const ViewAdvertReportsPage({Key? key, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            List<Widget> reports = [];
            for (ReportedAdvertModel advert in vm.adverts) {
              reports.add(QuickViewReportedAdvertCardWidget(
                  store: store, advert: advert));
            }
            Widget appbar = AppBarWidget(
              title: "Advert Reports",
              store: store,
              backButton: true,
            );
            return (vm.loading)
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        //**********APPBAR***********//
                        appbar,
                        //*******************************************//

                        LoadingWidget(
                            topPadding: MediaQuery.of(context).size.height / 3,
                            bottomPadding: 0)
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        //**********APPBAR***********//
                        appbar,
                        (reports.isEmpty)
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top: (MediaQuery.of(context).size.height) /
                                        4,
                                    left: 40,
                                    right: 40),
                                child: (const Text(
                                  "There are no reported adverts.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white70),
                                )),
                              )
                            : ListRefreshWidget(
                                widgets: reports,
                                refreshFunction: vm.dispatchGetAdvertReports,
                              )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, ViewAdvertReportsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        adverts: state.admin.adminManage.advertReports ?? [],
        dispatchGetAdvertReports: () => dispatch(GetReportedAdvertsAction()),
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final List<ReportedAdvertModel> adverts;
  final void Function() dispatchGetAdvertReports;

  _ViewModel({
    required this.loading,
    required this.adverts,
    required this.dispatchGetAdvertReports,
  }) : super(equals: [loading, adverts]); // implementinf hashcode;
}
