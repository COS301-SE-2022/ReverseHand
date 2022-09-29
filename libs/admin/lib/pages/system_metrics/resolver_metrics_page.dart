import 'package:admin/widgets/drop_down_options_widget.dart';
import 'package:admin/widgets/line_chart_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/admin/system_metrics/get_resolver_errors_action.dart';
import 'package:redux_comp/actions/admin/system_metrics/get_resolver_invocations_action.dart';
import 'package:redux_comp/models/admin/app_metrics/metrics_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ResolverMetricsPage extends StatefulWidget {
  final Store<AppState> store;
  const ResolverMetricsPage({Key? key, required this.store}) : super(key: key);

  @override
  State<ResolverMetricsPage> createState() => _ResolverMetricsPageState();
}

class _ResolverMetricsPageState extends State<ResolverMetricsPage> {
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
                  title: "Resolver Metrics",
                  backButton: true,
                  refreshAction: () {
                    vm.refresh(
                        vm.adminResolvers.period, vm.adminResolvers.time);
                    _zoomingPanBehavior.reset();
                  });
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
                              currentItem: "${vm.adminResolvers.period} min",
                              functions: {
                                "1 min": () =>
                                    vm.refresh(1, vm.adminResolvers.time),
                                "5 min": () =>
                                    vm.refresh(5, vm.adminResolvers.time),
                                "15 min": () =>
                                    vm.refresh(15, vm.adminResolvers.time),
                                "30 min": () =>
                                    vm.refresh(30, vm.adminResolvers.time),
                                "60 min": () =>
                                    vm.refresh(60, vm.adminResolvers.time),
                              },
                            ),
                            DropDownOptionsWidget(
                              title: "Time",
                              currentItem: "${vm.adminResolvers.time}hr ago",
                              functions: {
                                "3hr ago": () =>
                                    vm.refresh(vm.adminResolvers.period, 3),
                                "6hr ago": () =>
                                    vm.refresh(vm.adminResolvers.period, 6),
                                "12hr ago": () =>
                                    vm.refresh(vm.adminResolvers.period, 12),
                                "24hr ago": () =>
                                    vm.refresh(vm.adminResolvers.period, 24),
                              },
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Admin Resolvers",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        LineChartWidget(
                          graphs:
                              vm.adminResolvers.graphs["adminInvokeData"] ?? [],
                          chartTitle: "Invocations",
                          xTitle: "Time",
                          yTitle: "Count",
                          zoomPanBehavior: _zoomingPanBehavior,
                        ),
                        LineChartWidget(
                          graphs:
                              vm.adminResolvers.graphs["adminErrorData"] ?? [],
                          chartTitle: "Errors",
                          xTitle: "Time",
                          yTitle: "Count",
                          zoomPanBehavior: _zoomingPanBehavior,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "User Resolvers",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        LineChartWidget(
                          graphs:
                              vm.adminResolvers.graphs["userInvokeData"] ?? [],
                          chartTitle: "Invocations",
                          xTitle: "Time",
                          yTitle: "Count",
                          zoomPanBehavior: _zoomingPanBehavior,
                        ),
                        LineChartWidget(
                          graphs:
                              vm.adminResolvers.graphs["userErrorData"] ?? [],
                          chartTitle: "Errors",
                          xTitle: "Time",
                          yTitle: "Count",
                          zoomPanBehavior: _zoomingPanBehavior,
                        ),
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
class _Factory extends VmFactory<AppState, _ResolverMetricsPageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        refresh: (period, time) {
          dispatch(
            GetResolverInvocationsAction(
              period: period, //min
              hoursAgo: time,
            ),
          );
          dispatch(
            GetResolverErrorsAction(
              period: period, //min
              hoursAgo: time,
            ),
          );
        },
        loading: state.wait.isWaiting,
        adminResolvers: state.admin.appMetrics.adminResolvers ??
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
  final MetricsModel adminResolvers;

  final void Function(int, int) refresh;

  _ViewModel({
    required this.refresh,
    required this.loading,
    required this.adminResolvers,
  }) : super(equals: [
          loading,
          adminResolvers,
        ]); // implementinf hashcode;
}
