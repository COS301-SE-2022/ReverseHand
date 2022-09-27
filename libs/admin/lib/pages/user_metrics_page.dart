import 'package:admin/widgets/admin_navbar_widget.dart';
import 'package:admin/widgets/line_chart_widget.dart';
import 'package:admin/widgets/text_row_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/admin/app_management/list_users_action.dart';
import 'package:redux_comp/actions/admin/user_metrics/get_place_bid_metrics_action.dart';
import 'package:redux_comp/actions/admin/user_metrics/get_session_metrics_action.dart';
import 'package:redux_comp/models/admin/app_metrics/metrics_model.dart';
import 'package:redux_comp/redux_comp.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UserMetricsPage extends StatefulWidget {
  final Store<AppState> store;
  const UserMetricsPage({Key? key, required this.store}) : super(key: key);

  @override
  State<UserMetricsPage> createState() => _UserMetricsPageState();
}

class _UserMetricsPageState extends State<UserMetricsPage> {
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
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            Widget appbar = AppBarWidget(
                title: "User Metrics",
                store: widget.store,
                refreshAction: () {
                  vm.refresh(vm.sessions.period, vm.sessions.time);
                  _zoomingPanBehavior.reset();
                });
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
                      children: [
                        //**********APPBAR***********//
                        appbar,
                        TextRowWidget(textValMap: {
                          "Active Sessions": vm.activeSessions.toString()
                        }),
                        LineChartWidget(
                            graphs: vm.sessions.graphs["sessions"] ?? [],
                            chartTitle: "Sessions over the last 12 hours",
                            xTitle: "Time",
                            yTitle: "Count",
                            zoomPanBehavior: _zoomingPanBehavior),
                     
                        ButtonWidget(
                            text: "View Custom Metrics", function: vm.pushCustomMetricsPage),
                        ButtonWidget(
                            text: "View Chat Sentiment",
                            color: "dark",
                            function: vm.pushSentimentPage),
                        Divider(
                          height: 20,
                          thickness: 0.5,
                          indent: 15,
                          endIndent: 15,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        ButtonWidget(
                            text: "Search Users",
                            color: "dark",
                            function: vm.pushSearchUsersPage),
                      ],
                    ),
                  );
          },
        ),
        bottomNavigationBar: AdminNavBarWidget(store: widget.store),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, _UserMetricsPageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      loading: state.wait.isWaiting,
      sessions: state.admin.userMetrics.sessionMetrics ??
          const MetricsModel(period: 60, time: 3, graphs: {}),
      refresh: (period, time) =>
          dispatch(GetSessionMetricsAction(period: period, hoursAgo: time)),
      activeSessions: state.admin.userMetrics.activeSessions ?? 0,
      pushSearchUsersPage: () {
        dispatch(NavigateAction.pushNamed('/search_users'));
        dispatch(ListUsersAction("customer"));
        dispatch(ListUsersAction("tradesman"));
      },
      pushSentimentPage: () {
        dispatch(NavigateAction.pushNamed("/admin/sentiment"));
      }, 
      pushCustomMetricsPage: () {
        dispatch(NavigateAction.pushNamed('/admin/custom_metrics'));
        dispatch(GetPlaceBidMetricsAction(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)));
      },);
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final MetricsModel sessions;
  final void Function(int, int) refresh;
  final int activeSessions;
  final VoidCallback pushSearchUsersPage;
  final VoidCallback pushSentimentPage;
  final VoidCallback pushCustomMetricsPage;

  _ViewModel({
    required this.loading,
    required this.sessions,
    required this.activeSessions,
    required this.refresh,
    required this.pushSearchUsersPage,
    required this.pushSentimentPage,
    required this.pushCustomMetricsPage,
  }) : super(equals: [
          loading,
          sessions,
          activeSessions
        ]); // implementinf hashcode;
}

