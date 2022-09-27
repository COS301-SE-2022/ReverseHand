import 'package:admin/widgets/doughnut_chart_widget.dart';
import 'package:admin/widgets/drop_down_options_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/models/admin/user_metrics/chart_model.dart';
import 'package:redux_comp/models/admin/user_metrics/pie_chart_model.dart';
import 'package:redux_comp/redux_comp.dart';

class CustomMetricsPage extends StatelessWidget {
  final Store<AppState> store;

  const CustomMetricsPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<PieChartModel> placeData = [
      const PieChartModel(
          label: 'Pretoria', value: 25, color: Colors.redAccent),
      const PieChartModel(
          label: 'Centurion', value: 38, color: Colors.orangeAccent),
      const PieChartModel(
          label: 'Randburg', value: 34, color: Colors.blueAccent),
      const PieChartModel(
          label: 'Johannesburg', value: 5, color: Colors.greenAccent),
    ];
    final List<PieChartModel> typeData = [
      const PieChartModel(label: 'Plumbing', value: 5, color: Colors.redAccent),
      const PieChartModel(
          label: 'Painting', value: 7, color: Colors.orangeAccent),
      const PieChartModel(
          label: 'Electrician', value: 11, color: Colors.blueAccent),
      const PieChartModel(
          label: 'Cleaner', value: 5, color: Colors.greenAccent),
    ];
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            Widget appbar = AppBarWidget(
              title: "Custom Metrics",
              store: store,
              backButton: true,
            );
            final start = DateTime.utc(1970, 1, 1);
            final end = DateTime.utc(2038, 12, 31);

            return (vm.loading)
                ? Column(
                    children: [
                      //**********APPBAR***********//
                      appbar,
                      //*******************************************//

                      LoadingWidget(
                          topPadding: MediaQuery.of(context).size.height / 3,
                          bottomPadding: 0)
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //**********APPBAR***********//
                        appbar,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DropDownOptionsWidget(
                              title: "Event",
                              functions: {
                                "Create Advert": () {},
                                "Place Bid": () {}
                              },
                              currentItem: "Create Advert",
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Text(
                                    DateTime.now()
                                        .toIso8601String()
                                        .substring(0, 10),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.orangeAccent,
                                    )),
                              ),
                              onTap: () => showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: start,
                                lastDate: end,
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: Theme.of(context).primaryColor,
                                        onPrimary: Colors.black,
                                        onSurface: Colors.black,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor:
                                              Colors.black, // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        DoughnutChartWidget(
                            graphs: [vm.placeBidMetrics.graphs["bidsByType"] ?? []], chartTitle: "Job Type"),
                        DoughnutChartWidget(
                            graphs: [placeData], chartTitle: "Location")
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
class _Factory extends VmFactory<AppState, CustomMetricsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        placeBidMetrics: state.admin.userMetrics.placeBidMetrics ??
            ChartModel(graphs: const {}, time: DateTime.now()),
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final ChartModel placeBidMetrics;

  _ViewModel({
    required this.loading,
    required this.placeBidMetrics,
  }) : super(equals: [loading]); // implementinf hashcode;
}

class ChartData {
  ChartData({required this.x, required this.y, this.color});
  final String x;
  final double y;
  final Color? color;
}
