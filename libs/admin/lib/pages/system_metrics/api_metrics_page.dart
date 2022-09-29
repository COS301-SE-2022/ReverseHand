import 'package:admin/widgets/drop_down_options_widget.dart';
import 'package:admin/widgets/line_chart_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/admin/system_metrics/get_api_metrics_action.dart';
import 'package:redux_comp/models/admin/app_metrics/metrics_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ApiMetricsPage extends StatefulWidget {
  final Store<AppState> store;
  const ApiMetricsPage({Key? key, required this.store}) : super(key: key);

  @override
  State<ApiMetricsPage> createState() => _ApiMetricsPageState();
}

class _ApiMetricsPageState extends State<ApiMetricsPage> {
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
                title: "API Metrics",
                backButton: true,
                refreshAction: () {
                    vm.refresh(vm.apiMetrics.period, vm.apiMetrics.time);
                    _zoomingPanBehavior.reset();
                }
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
                              currentItem: "${vm.apiMetrics.period} min",
                              functions: {
                                "1 min": () =>
                                    vm.refresh(1, vm.apiMetrics.time),
                                "5 min": () =>
                                    vm.refresh(5, vm.apiMetrics.time),
                                "15 min": () =>
                                    vm.refresh(15, vm.apiMetrics.time),
                                "30 min": () =>
                                    vm.refresh(30, vm.apiMetrics.time),
                                "60 min": () =>
                                    vm.refresh(60, vm.apiMetrics.time),
                              },
                            ),
                            DropDownOptionsWidget(
                              title: "Time",
                              currentItem: "${vm.apiMetrics.time}hr ago",
                              functions: {
                                "3hr ago": () =>
                                    vm.refresh(vm.apiMetrics.period, 3),
                                "6hr ago": () =>
                                    vm.refresh(vm.apiMetrics.period, 6),
                                "12hr ago": () =>
                                    vm.refresh(vm.apiMetrics.period, 12),
                                "24hr ago": () =>
                                    vm.refresh(vm.apiMetrics.period, 24),
                              },
                            ),
                          ],
                        ),
                        LineChartWidget(
                            graphs: vm.apiMetrics.graphs["apiLatency"] ?? [],
                            chartTitle: "API Latency",
                            xTitle: "Time",
                            yTitle: "Miliseconds",
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
class _Factory extends VmFactory<AppState, _ApiMetricsPageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        refresh: (period, time) {
          dispatch(GetApiMetricsAction(period: period, hoursAgo: time));
        },
        loading: state.wait.isWaiting,
        apiMetrics: state.admin.appMetrics.apiMetrics ??
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
  final MetricsModel apiMetrics;

  final void Function(int, int) refresh;

  _ViewModel({
    required this.refresh,
    required this.loading,
    required this.apiMetrics,
  }) : super(equals: [
          loading,
          apiMetrics,
        ]); // implementinf hashcode;
}
