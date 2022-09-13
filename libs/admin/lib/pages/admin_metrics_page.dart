import 'package:admin/widgets/admin_navbar_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/get_db_write_metrics_action.dart';
import 'package:redux_comp/redux_comp.dart';

class AdminMetricsPage extends StatelessWidget {
  final Store<AppState> store;
  const AdminMetricsPage({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        body: SingleChildScrollView(
          child: StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(this),
            builder: (BuildContext context, _ViewModel vm) {
              return (vm.loading)
                  ? Column(
                      children: [
                        //**********APPBAR***********//
                        AppBarWidget(title: "App Metrics", store: store),
                        //*******************************************//

                        LoadingWidget(
                            topPadding: MediaQuery.of(context).size.height / 3,
                            bottomPadding: 0)
                      ],
                    )
                  : Column(
                      children: [
                        //**********APPBAR***********//
                        AppBarWidget(title: "App Metrics", store: store),

                        ButtonWidget(text: "PRESS ME", function: vm.getDBWriteMetrics),
                        vm.dash
                      ],
                    );
            },
          ),
        ),
        bottomNavigationBar: AdminNavBarWidget(store: store),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, AdminMetricsPage> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        loading: state.wait.isWaiting,
        dash: state.admin.dash ?? const Text("hi"),
        getDBWriteMetrics: () => dispatch(GetDbWriteMetricsAction()),);
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final Widget dash;
  final void Function() getDBWriteMetrics;

  _ViewModel({
    required this.loading,
    required this.dash,
    required this.getDBWriteMetrics,
  }) : super(equals: [loading, dash]); // implementinf hashcode;
}
