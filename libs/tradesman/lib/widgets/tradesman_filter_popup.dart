import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/user_models/user_model.dart';

class FilterPopUpWidget extends StatefulWidget {
  final Store<AppState> store;

  const FilterPopUpWidget({Key? key, required this.store}) : super(key: key);

  @override
  State<FilterPopUpWidget> createState() => _FilterPopUpWidgetState();
}

class _FilterPopUpWidgetState extends State<FilterPopUpWidget> {
  final String? dropDownListVal = "None";

  final TextEditingController minDistanceController = TextEditingController();

  final TextEditingController maxDistanceController = TextEditingController();

  final List<String> _dropdownValues1 = [
    "None",
    "Date added",
  ];

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: StoreConnector<AppState, _ViewModel>(
        vm: () => _Factory(widget),
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
                  onChanged: (String? kind) {},
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

              //*********SECOND FILTER: RANGES***********/
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //MINIMUM TEXTFIELD
                  Container(
                      height: 40,
                      width: (MediaQuery.of(context).size.width / 1.7) / 2,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(
                            20.0), //borderRadius for container
                      ),
                      child: TextFormField(
                        // initialValue: "0",
                        style: const TextStyle(color: Colors.white),
                        controller: minDistanceController,
                        decoration: InputDecoration(
                          labelText: "min",
                          labelStyle: const TextStyle(color: Colors.white),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.orange,
                              width: 2.0,
                            ),
                          ),
                        ),
                      )),

                  //PADDING AND "-"
                  const Padding(padding: EdgeInsets.all(5)),

                  const Text(
                    "-",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),

                  //MAXIMUM TEXTFIELD
                  Container(
                      height: 40,
                      width: (MediaQuery.of(context).size.width / 1.7) / 2,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(
                            20.0), //borderRadius for container
                      ),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        controller: maxDistanceController,
                        decoration: InputDecoration(
                          labelText: "max",
                          labelStyle: const TextStyle(color: Colors.white),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Colors.orange,
                              width: 2.0,
                            ),
                          ),
                        ),
                      )),
                ],
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
                      height: 120,
                      child: ListView(
                        children: vm.userDetails.tradeTypes
                            .map((element) => CheckboxListTile(
                                  title: Text(element),
                                  value: true,
                                  activeColor: Theme.of(context).primaryColor,
                                  onChanged: (bool? value) {},
                                ))
                            .toList(),
                      ),
                    ),
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
                      height: 120,
                      child: ListView(
                        children: vm.userDetails.domains
                            .map((domain) => CheckboxListTile(
                                  title: Text(domain.city),
                                  value: true,
                                  activeColor: Theme.of(context).primaryColor,
                                  onChanged: (bool? value) {},
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              //*******************************************/

              const Padding(padding: EdgeInsets.all(10)),

              //*****************BUTTONS*******************/

              ButtonWidget(
                text: "Apply",
                function: () {},
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
      );
}

// view model
class _ViewModel extends Vm {
  final UserModel userDetails;

  _ViewModel({
    required this.userDetails,
  }) : super(equals: [userDetails]);
}
