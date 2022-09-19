import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/job_card.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:general/widgets/long_button_transparent.dart';
import 'package:general/widgets/long_button_widget.dart';
import 'package:redux_comp/models/admin/reported_advert_model.dart';
import 'package:redux_comp/redux_comp.dart';
import '../../../widgets/report_details_widget.dart';

class AdvertReportsManagePage extends StatelessWidget {
  final Store<AppState> store;

  const AdvertReportsManagePage({Key? key, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReportedAdvertModel advert =
        ModalRoute.of(context)!.settings.arguments as ReportedAdvertModel;
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) {
              List<ReportDetailsWidget> reports = [];
              for (var report in advert.reports) {
                reports.add(ReportDetailsWidget(
                   reason: report.reason,
                   description: report.description,
                    ));
              }
              Widget appbar = AppBarWidget(
                title: "Manage Advert Report",
                store: store,
                backButton: true,
              );
              return (vm.loading)
                  ? Column(
                      children: [
                        //**********APPBAR***************************//
                        appbar,
                        //*******************************************//

                        LoadingWidget(
                            topPadding: MediaQuery.of(context).size.height / 3,
                            bottomPadding: 0)
                      ],
                    )
                  : Column(
                      children: [
                        //**********APPBAR***************************//
                        appbar,
                        //*******************************************//

                        //put advert details here
                        //also put advert pictures here?
                        JobCardWidget(
                          titleText: advert.advert.title,
                          descText: advert.advert.description ?? "null desc",
                          location:
                              "${advert.advert.domain.city}, ${advert.advert.domain.province}",
                          type: advert.advert.type,
                          date: DateTime.fromMicrosecondsSinceEpoch(
                                  advert.advert.dateCreated.floor() * 1000)
                              .toString(),
                          store: store,
                        ),
                        //count
                        Padding(
                          padding: const EdgeInsets.only(left: 38.0, top: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Report count: ${advert.count.toString()}",
                              style: const TextStyle(
                                fontSize: 17,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        //reason and description
                        ...reports,

                        //******************BUTTONS*********************//
                        LongButtonWidget(
                            text: "Issue Warning", function: () {}),
                        TransparentLongButtonWidget(
                            text: "Remove Advert", function: () {}),
                        //**********************************************//
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, AdvertReportsManagePage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;

  _ViewModel({
    required this.loading,
  }) : super(equals: [loading]); // implementinf hashcode;
}
