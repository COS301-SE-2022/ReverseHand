import 'package:admin/widgets/drop_down_options_widget.dart';
import 'package:admin/widgets/system_charts/line_chart_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/admin/system_metrics/get_lambda_metrics_action.dart';
import 'package:redux_comp/models/admin/app_metrics/metrics_model.dart';
import 'package:redux_comp/redux_comp.dart';

class ResolverMetricsPage extends StatefulWidget {
  final Store<AppState> store;
  const ResolverMetricsPage({Key? key, required this.store}) : super(key: key);

  @override
  State<ResolverMetricsPage> createState() => _ResolverMetricsPageState();
}

class _ResolverMetricsPageState extends State<ResolverMetricsPage> {
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
                refreshAction: () => vm.refresh(
                    vm.adminResolvers.period, vm.adminResolvers.time),
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
                        LineChartWidget(
                          graphs: vm.adminResolvers.graphs["adminData"] ?? [],
                          chartTitle: "Admin Resolvers Invocations",
                          xTitle: "Time",
                          yTitle: "Count",
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
          dispatch(GetLambdaMetricsAction(period: period, hoursAgo: time));
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
