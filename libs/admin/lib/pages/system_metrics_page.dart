import 'package:admin/widgets/admin_navbar_widget.dart';
import 'package:admin/widgets/box_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/admin/system_metrics/get_api_metrics_action.dart';
import 'package:redux_comp/actions/admin/system_metrics/get_db_metrics_action_action.dart';
import 'package:redux_comp/redux_comp.dart';

class SystemMetricsPage extends StatefulWidget {
  final Store<AppState> store;
  const SystemMetricsPage({Key? key, required this.store}) : super(key: key);

  @override
  State<SystemMetricsPage> createState() => _SystemMetricsPageState();
}

class _SystemMetricsPageState extends State<SystemMetricsPage> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) {
              Widget appbar =
                  AppBarWidget(title: "System Metrics", store: widget.store);
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
                  : Column(
                      children: [
                        //**********APPBAR***********//
                        appbar,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BoxWidget(
                              color: Colors.orangeAccent,
                              text: "Database",
                              icon: Icons.storage,
                              function: vm.pushDBMetricsPage,
                            ),
                            BoxWidget(
                              color: Colors.green,
                              text: "API",
                              icon: Icons.network_ping,
                              function: vm.pushApiMetrics,
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            BoxWidget(
                              color: Colors.purple,
                              text: "Resolvers",
                              icon: Icons.code,
                              function: () {},
                            ),
                            BoxWidget(
                              color: Colors.red,
                              text: "Auth",
                              icon: Icons.security,
                              function: () {},
                            ),
                          ],
                        ),
                      ],
                    );
            },
          ),
        ),
        bottomNavigationBar: AdminNavBarWidget(store: widget.store),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, _SystemMetricsPageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      loading: state.wait.isWaiting,
      pushApiMetrics: () {
        dispatch(NavigateAction.pushNamed('/api_metrics'));
        dispatch(
          GetApiMetricsAction(
            hoursAgo: state.admin.appMetrics.apiMetrics?.time ?? 3,
            period: state.admin.appMetrics.apiMetrics?.period ?? 5,
          ),
        );
      },
      pushDBMetricsPage: () {
        dispatch(NavigateAction.pushNamed('/database_metrics'));
        dispatch(
          GetDbMetricsAction(
            period: state.admin.appMetrics.databaseMetrics?.period ?? 5, //min
            hoursAgo:
                state.admin.appMetrics.databaseMetrics?.time ?? 3, // hours
          ),
        );
      });
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final VoidCallback pushDBMetricsPage;
  final VoidCallback pushApiMetrics;

  _ViewModel({
    required this.loading,
    required this.pushDBMetricsPage,
    required this.pushApiMetrics,
  }) : super(equals: [loading]); // implementinf hashcode;
}
