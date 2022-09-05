import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';
import 'package:redux_comp/actions/adverts/filter_adverts_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/filter_adverts_model.dart';
import 'package:redux_comp/models/user_models/user_model.dart';

class FilterPopUpWidget extends StatefulWidget {
  final Store<AppState> store;

  const FilterPopUpWidget({Key? key, required this.store}) : super(key: key);

  @override
  State<FilterPopUpWidget> createState() => _FilterPopUpWidgetState();
}

class _FilterPopUpWidgetState extends State<FilterPopUpWidget> {
  String? dropDownListVal = "None";

  final TextEditingController distanceController = TextEditingController();

  double _currentSliderValue = 20;

  final List<String> _dropdownValues1 = [
    "None",
    "Date added",
  ];

  final Map<String, bool> values = {};
  final Map<String, bool> domains = {};

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(widget),
        onInit: (store) {
          for (String tradeType in store.state.userDetails!.tradeTypes) {
            values[tradeType] = true;
          }

          for (var i = 0; i < store.state.userDetails!.domains.length; i++) {
            domains[store.state.userDetails!.domains.elementAt(i).city] = true;
          }
        },
        builder: (BuildContext context, _ViewModel vm) => SingleChildScrollView(
          child: Column(
            children: [
              //*********FIRST FILTER: HEADING***********/
              const Padding(
                padding: EdgeInsets.only(left: 45, top: 30),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Sort By:",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              //*****************************************/

              const Padding(padding: EdgeInsets.only(bottom: 10)),

              //*********SORT BY DROPDOWN****************/
              Container(
                padding: const EdgeInsets.all(10),
                height: 40,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius:
                      BorderRadius.circular(20.0), //borderRadius for container
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                child: DropdownButton(
                  dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(
                      20.0), //borderRadius for dropdownMenu
                  isExpanded: true,
                  underline: const SizedBox.shrink(),
                  value: dropDownListVal,
                  icon: const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                  ),
                  items: _dropdownValues1
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (String? kind) {
                    setState(() {
                      dropDownListVal = kind;
                    });
                  },
                ),
              ),
              //******************************************/

              //*********SECOND FILTER: HEADING***********/
              const Padding(
                padding: EdgeInsets.only(left: 45, top: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Distance (km):",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              //******************************************/

              //*********SECOND FILTER: SLIDER***********/
              SizedBox(
                width: (MediaQuery.of(context).size.width / 1.35),
                //colors
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Theme.of(context).primaryColor,
                      inactiveTrackColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      thumbColor: Theme.of(context).primaryColor,
                      valueIndicatorColor: Theme.of(context).primaryColorLight,
                      inactiveTickMarkColor:
                          Theme.of(context).primaryColorLight),
                  //actual slider
                  child: Slider(
                      value: _currentSliderValue,
                      max: 100,
                      divisions: 10,
                      label: "${_currentSliderValue.round()} km",
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      }),
                ),
              ),
              //******************************************/

              //*********THIRD FILTER: HEADING***********/
              const Padding(
                padding: EdgeInsets.only(left: 45, top: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Job Types:",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              //*****************************************/

              const Padding(padding: EdgeInsets.only(bottom: 10)),

              //*********THIRD FILTER: CHECKBOXES***********/

              Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius:
                      BorderRadius.circular(20.0), //borderRadius for container
                ),
                child: Column(
                  children: [
                    SizedBox(
                        width: 200,
                        //the height of the box should increase and be scrollable
                        //only if more than 1 item is present
                        height: (vm.userDetails.tradeTypes.toList().length) > 1
                            ? 120
                            : 60,
                        child: ListView(
                            children:
                                vm.userDetails.tradeTypes.map((String key) {
                          return CheckboxListTile(
                              title: Text(key),
                              value: values[key],
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (bool? value) {
                                setState(() {
                                  values[key] = value!;
                                });
                              });
                        }).toList())),
                  ],
                ),
              ),
              //*******************************************/

              //*********FOURTH FILTER: HEADING***********/
              const Padding(
                padding: EdgeInsets.only(left: 45, top: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Domains:",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              //*****************************************/
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              //*********FOURTH FILTER: CHECKBOXES***********/
              Container(
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius:
                      BorderRadius.circular(20.0), //borderRadius for container
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: 200,
                      //the height of the box should increase and be scrollable
                      //only if more than 1 item is present
                      height: (vm.userDetails.domains.toList().length) > 1
                          ? 120
                          : 60,
                      child: ListView(
                          children: vm.userDetails.domains
                              .map((domain) => CheckboxListTile(
                                    title: Text(domain.city),
                                    value: domains[domain.city],
                                    activeColor: Theme.of(context).primaryColor,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        domains[domain.city] = value!;
                                      });
                                    },
                                  ))
                              .toList()),
                    ),
                  ],
                ),
              ),
              //*******************************************/

              const Padding(padding: EdgeInsets.all(10)),

              //*****************BUTTONS*******************/

              ButtonWidget(
                text: "Apply",
                function: () {
                  vm.dispatchFilterAdvertsAction(
                    const FilterAdvertsModel(
                        // distance: minDistanceController.value.text.isEmpty ||
                        //         maxDistanceController.value.text.isEmpty
                        //     ? null
                        //     : Range(
                        //         int.parse(minDistanceController.value.text),
                        //         int.parse(maxDistanceController.value.text),
                        //       ),
                        ),
                  );
                  Navigator.pop(context);
                },
              ),
              ButtonWidget(
                  text: "Cancel",
                  color: "light",
                  border: "white",
                  function: () {
                    Navigator.pop(context);
                  }),

              //*******************************************/
              const Padding(padding: EdgeInsets.all(20))
            ],
          ),
        ),
      ),
    );
  }
}

class _Factory extends VmFactory<AppState, FilterPopUpWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        userDetails: state.userDetails!,
        dispatchFilterAdvertsAction: (FilterAdvertsModel filter) =>
            dispatch(FilterAdvertsAction(filter)),
      );
}

// view model
class _ViewModel extends Vm {
  final UserModel userDetails;
  final void Function(FilterAdvertsModel) dispatchFilterAdvertsAction;

  _ViewModel({
    required this.userDetails,
    required this.dispatchFilterAdvertsAction,
  }) : super(equals: [userDetails]);
}
