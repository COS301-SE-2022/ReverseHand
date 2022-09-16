import 'package:admin/widgets/admin_navbar_widget.dart';
import 'package:admin/widgets/system_charts/line_chart_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/models/admin/app_metrics/metric_chart_model.dart';
import 'package:redux_comp/redux_comp.dart';

class SystemMetricsPage extends StatefulWidget {
  final Store<AppState> store;
  const SystemMetricsPage({Key? key, required this.store}) : super(key: key);

  @override
  State<SystemMetricsPage> createState() => _SystemMetricsPageState();
}

class _SystemMetricsPageState extends State<SystemMetricsPage> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
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

                      
                        (vm.data != null) ?
                          LineChartWidget(data: vm.data!) : Container()
                    
                    ],
                  );
          },
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
        data: state.admin.appMetrics.dbWriteGraph,
      );
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final MetricChartModel? data;

  _ViewModel({
    required this.loading,
    required this.data,
  }) : super(equals: [loading, data]); // implementinf hashcode;
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
