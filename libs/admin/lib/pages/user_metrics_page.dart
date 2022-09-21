import 'package:admin/widgets/admin_navbar_widget.dart';
import 'package:admin/widgets/system_charts/doughnut_chart_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/models/admin/user_metrics/pie_chart_model.dart';
import 'package:redux_comp/redux_comp.dart';

class UserMetricsPage extends StatelessWidget {
  final Store<AppState> store;
  const UserMetricsPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            final List<List<PieChartModel>> chartData = [[
              const PieChartModel(label: 'Kwa-Zulu Natal', value: 15),
              const PieChartModel(label: 'Western Cape',value:  38),
              const PieChartModel(label: 'Free State',value:  34),
              const PieChartModel(label: 'Gauteng',value:  52)
            ]];

            Widget appbar = AppBarWidget(
              title: "User Metrics",
              store: store,
            );
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

                      DoughnutChartWidget(graphs: chartData, chartTitle: "App Demographics")
                    ],
                  );
          },
        ),
        bottomNavigationBar: AdminNavBarWidget(store: store),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, UserMetricsPage> {
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

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
