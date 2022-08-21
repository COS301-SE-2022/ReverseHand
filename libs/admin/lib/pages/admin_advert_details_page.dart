import 'package:admin/widgets/quickview_report_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/methods/time.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/job_card.dart';
import 'package:redux_comp/models/admin/advert_report_model.dart';
import 'package:redux_comp/models/admin/reported_advert_model.dart';
import 'package:redux_comp/models/advert_model.dart';
import 'package:redux_comp/redux_comp.dart';

class AdminAdvertDetailsPage extends StatelessWidget {
  final Store<AppState> store;
  const AdminAdvertDetailsPage({Key? key, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: Scaffold(
            body: SingleChildScrollView(
                child: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            
            List<Widget> reports = [];
            for (AdvertReportModel report in vm.reports) {
              reports.add(QuickviewReportWidget(report: report, store: store));
            }
            
            
            
            return Column(children: [
              //**********APPBAR***********//
              AppBarWidget(title: "JOB INFO", store: store),
              //*******************************************//

              //**********DETAILED JOB INFORMATION***********//
              JobCardWidget(
                titleText: vm.activeAdvert.advert.title,
                descText: vm.activeAdvert.advert.description ?? "",
                location: vm.activeAdvert.advert.domain.city,
                type: vm.activeAdvert.advert.type ?? "",
                date: timestampToDate(vm.activeAdvert.advert.dateCreated),
              ),
              //*******************************************//


              ...reports
            ]);
          },
        ))));
  }
}

class _Factory extends VmFactory<AppState, AdminAdvertDetailsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        reports: state.admin.activeAdvert!.reports,
        activeAdvert: state.admin.activeAdvert!,
      );
}

// view model
class _ViewModel extends Vm {
  final List<AdvertReportModel> reports;
  final ReportedAdvertModel activeAdvert;

  _ViewModel({
    required this.reports,
    required this.activeAdvert,
  }) : super(equals: [reports, activeAdvert]);
}
