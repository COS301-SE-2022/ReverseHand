import 'package:admin/widgets/drop_down_options_widget.dart';
import 'package:admin/widgets/line_chart_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/admin/system_metrics/get_db_metrics_action_action.dart';
import 'package:redux_comp/models/admin/app_metrics/metrics_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DatabaseMetricsPage extends StatefulWidget {
  final Store<AppState> store;
  const DatabaseMetricsPage({Key? key, required this.store}) : super(key: key);

  @override
  State<DatabaseMetricsPage> createState() => _DatabaseMetricsPageState();
}

class _DatabaseMetricsPageState extends State<DatabaseMetricsPage> {
  late ZoomPanBehavior _zoomingPanBehavior;
  @override
  void initState() {
    _zoomingPanBehavior = ZoomPanBehavior(
        enablePanning: true,
        enableSelectionZooming: true,
        selectionRectBorderColor: Colors.orange,
        selectionRectBorderWidth: 1,
        selectionRectColor: Colors.grey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) {
              Widget appBar = AppBarWidget(
                store: widget.store,
                title: "Database Metrics",
                backButton: true,
                refreshAction: () {
                  vm.refresh(vm.dbMetrics.period, vm.dbMetrics.time);
                  _zoomingPanBehavior.reset();
                },
              );
              return (vm.loading)
                  ? Column(
                      children: [
                        appBar,
                        LoadingWidget(
                          topPadding: MediaQuery.of(context).size.height / 3,
                          bottomPadding: 0,
                        )
                      ],
                    )
                  : Column(
                      children: [
                        appBar,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DropDownOptionsWidget(
                              title: "Period",
                              currentItem: "${vm.dbMetrics.period} min",
                              functions: {
                                "1 min": () => vm.refresh(1, vm.dbMetrics.time),
                                "5 min": () => vm.refresh(5, vm.dbMetrics.time),
                                "15 min": () =>
                                    vm.refresh(15, vm.dbMetrics.time),
                                "30 min": () =>
                                    vm.refresh(30, vm.dbMetrics.time),
                                "60 min": () =>
                                    vm.refresh(60, vm.dbMetrics.time),
                              },
                            ),
                            DropDownOptionsWidget(
                              title: "Time",
                              currentItem: "${vm.dbMetrics.time}hr ago",
                              functions: {
                                "3hr ago": () =>
                                    vm.refresh(vm.dbMetrics.period, 3),
                                "6hr ago": () =>
                                    vm.refresh(vm.dbMetrics.period, 6),
                                "12hr ago": () =>
                                    vm.refresh(vm.dbMetrics.period, 12),
                                "24hr ago": () =>
                                    vm.refresh(vm.dbMetrics.period, 24),
                              },
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "ReverseHand Table",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        LineChartWidget(
                          graphs: vm.dbMetrics.graphs["dbReadData"] ?? [],
                          chartTitle: "Read Capacity",
                          xTitle: "Time",
                          yTitle: "RCU",
                          zoomPanBehavior: _zoomingPanBehavior,
                        ),
                        LineChartWidget(
                            graphs: vm.dbMetrics.graphs["dbWriteData"] ?? [],
                            chartTitle: "Write Capacity",
                            xTitle: "Time",
                            yTitle: "WCU",
                            zoomPanBehavior: _zoomingPanBehavior,),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, _DatabaseMetricsPageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        refresh: (period, time) {
          dispatch(GetDbMetricsAction(period: period, hoursAgo: time));
        },
        loading: state.wait.isWaiting,
        dbMetrics: state.admin.appMetrics.databaseMetrics ??
            const MetricsModel(
              period: 5,
              time: 3,
              graphs: {},
            ),
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final MetricsModel dbMetrics;

  final void Function(int, int) refresh;

  _ViewModel({
    required this.refresh,
    required this.loading,
    required this.dbMetrics,
  }) : super(equals: [
          loading,
          dbMetrics,
        ]); // implementinf hashcode;
}
