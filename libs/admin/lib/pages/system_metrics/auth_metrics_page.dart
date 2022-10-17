import 'package:admin/widgets/drop_down_options_widget.dart';
import 'package:admin/widgets/line_chart_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/admin/system_metrics/get_auth_metrics_action.dart';
import 'package:redux_comp/models/admin/app_metrics/metrics_model.dart';
import 'package:redux_comp/redux_comp.dart';

class AuthMetricsPage extends StatefulWidget {
  final Store<AppState> store;
  const AuthMetricsPage({Key? key, required this.store}) : super(key: key);

  @override
  State<AuthMetricsPage> createState() => _AuthMetricsPageState();
}

class _AuthMetricsPageState extends State<AuthMetricsPage> {

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
                  title: "Auth Metrics",
                  backButton: true,
                  refreshAction: () {
                    vm.refresh(vm.authMetrics.period, vm.authMetrics.time);
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
                              currentItem: "${vm.authMetrics.period} min",
                              functions: {
                                "1 min": () =>
                                    vm.refresh(1, vm.authMetrics.time),
                                "5 min": () =>
                                    vm.refresh(5, vm.authMetrics.time),
                                "15 min": () =>
                                    vm.refresh(15, vm.authMetrics.time),
                                "30 min": () =>
                                    vm.refresh(30, vm.authMetrics.time),
                                "60 min": () =>
                                    vm.refresh(60, vm.authMetrics.time),
                              },
                            ),
                            DropDownOptionsWidget(
                              title: "Time",
                              currentItem: "${vm.authMetrics.time}hr ago",
                              functions: {
                                "3hr ago": () =>
                                    vm.refresh(vm.authMetrics.period, 3),
                                "6hr ago": () =>
                                    vm.refresh(vm.authMetrics.period, 6),
                                "12hr ago": () =>
                                    vm.refresh(vm.authMetrics.period, 12),
                                "24hr ago": () =>
                                    vm.refresh(vm.authMetrics.period, 24),
                              },
                            ),
                          ],
                        ),
                        LineChartWidget(
                          graphs: vm.authMetrics.graphs["authMetrics"] ?? [],
                          chartTitle: "Auth metrics",
                          xTitle: "Time",
                          yTitle: "Miliseconds",
                          
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
class _Factory extends VmFactory<AppState, _AuthMetricsPageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        refresh: (period, time) {
          dispatch(GetAuthMetricsAction(period: period, hoursAgo: time));
        },
        loading: state.wait.isWaiting,
        authMetrics: state.admin.appMetrics.authMetrics ??
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
  final MetricsModel authMetrics;

  final void Function(int, int) refresh;

  _ViewModel({
    required this.refresh,
    required this.loading,
    required this.authMetrics,
  }) : super(equals: [
          loading,
          authMetrics,
        ]); // implementinf hashcode;
}
