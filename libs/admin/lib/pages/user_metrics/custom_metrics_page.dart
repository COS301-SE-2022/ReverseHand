import 'package:admin/widgets/drop_down_options_widget.dart';
import 'package:admin/widgets/grouped_doughnut_chart_widget.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/appbar.dart';
import 'package:general/widgets/loading_widget.dart';
import 'package:redux_comp/actions/admin/user_metrics/get_bid_amount_metrics_action.dart';
import 'package:redux_comp/actions/admin/user_metrics/get_place_bid_metrics_action.dart';
import 'package:redux_comp/models/admin/user_metrics/chart_model.dart';
import 'package:redux_comp/redux_comp.dart';

class CustomMetricsPage extends StatefulWidget {
  final Store<AppState> store;

  const CustomMetricsPage({Key? key, required this.store}) : super(key: key);

  @override
  State<CustomMetricsPage> createState() => _CustomMetricsPageState();
}

class _CustomMetricsPageState extends State<CustomMetricsPage> {
  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String currentEvent = "Create Advert";

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: Scaffold(
        body: StoreConnector<AppState, _ViewModel>(
          vm: () => _Factory(this),
          builder: (BuildContext context, _ViewModel vm) {
            Widget appbar = AppBarWidget(
              title: "Custom Metrics",
              store: widget.store,
              backButton: true,
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
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //**********APPBAR***********//
                        appbar,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DropDownOptionsWidget(
                              title: "Event",
                              functions: {
                                "Create Advert": () {
                                  setState(() {
                                    currentEvent = "Create Advert";
                                  });
                                  vm.refresh(currentEvent, date);
                                },
                                "Place Bid": () {
                                  setState(() {
                                    currentEvent = "Place Bid";
                                  });
                                  vm.refresh(currentEvent, date);
                                }
                              },
                              currentItem: currentEvent,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.only(left: 45),
                              child: GestureDetector(
                                child: Text(
                                    date.toIso8601String().substring(0, 10),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    )),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: date,
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2100),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary:
                                                Theme.of(context).primaryColor,
                                            onPrimary: Colors.black,
                                            onSurface: Colors.black,
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors
                                                  .black, // button text color
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );

                                  setState(() {
                                    date = pickedDate ??
                                        DateTime
                                            .now(); //set output date to TextField value.
                                  });
                                  vm.refresh(currentEvent, date);
                                },
                              ),
                            )
                          ],
                        ),
                        if (currentEvent == "Create Advert")
                          GroupedDoughnutChartWidget(graphs: {
                            "Job Type":
                                vm.createAdvertMetrics.graphs["advertsByType"] ?? [],
                            "Cities":
                                vm.createAdvertMetrics.graphs["advertsByCity"] ?? [],
                          })
                        else if (currentEvent == "Place Bid")
                          GroupedDoughnutChartWidget(graphs: {
                            "Job Type":
                                vm.placeBidMetrics.graphs["bidsByType"] ?? [],
                            "Amount placed for bid":
                                vm.placeBidMetrics.graphs["bidsByAmount"] ?? [],
                          })
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, _CustomMetricsPageState> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
      loading: state.wait.isWaiting,
      placeBidMetrics: state.admin.userMetrics.placeBidMetrics ??
          const ChartModel(graphs: {}),
      createAdvertMetrics: state.admin.userMetrics.createAdvertMetrics ??
          const ChartModel(graphs: {}),
      refresh: (event, time) {
        if (event == "Place Bid") {
          dispatch(GetPlaceBidMetricsAction(time));
          dispatch(GetBidAmountMetricsAction(time));
        } else if (event == "Create Advert") {
          dispatch(GetPlaceBidMetricsAction(time));
          dispatch(GetBidAmountMetricsAction(time));
        }
      });
}

// view model
class _ViewModel extends Vm {
  final bool loading;
  final ChartModel placeBidMetrics;
  final ChartModel createAdvertMetrics;
  final void Function(String, DateTime) refresh;

  _ViewModel({
    required this.loading,
    required this.placeBidMetrics,
    required this.createAdvertMetrics,
    required this.refresh,
  }) : super(equals: [loading, placeBidMetrics]); // implementinf hashcode;
}

class ChartData {
  ChartData({required this.x, required this.y, this.color});
  final String x;
  final double y;
  final Color? color;
}
