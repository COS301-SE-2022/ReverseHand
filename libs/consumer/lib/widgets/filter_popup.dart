import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/methods/toast_error.dart';
import 'package:general/widgets/button.dart';
import 'package:redux_comp/actions/adverts/filter_bids_action.dart';
import 'package:redux_comp/app_state.dart';
import 'package:redux_comp/models/filter_bids_model.dart';

// for now staeful change to stateless later using store chanegd variable
// filter popup

class FilterPopUpWidget extends StatefulWidget {
  final Store<AppState> store;

  const FilterPopUpWidget({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  State<FilterPopUpWidget> createState() => _FilterPopUpWidgetState();
}

class _FilterPopUpWidgetState extends State<FilterPopUpWidget> {
  bool showBids = true;
  bool showSBids = true;
  Sort? sort;
  String? dropDownListVal = "None";
  final TextEditingController minController = TextEditingController();
  final TextEditingController maxController = TextEditingController();

  // items in drop down list
  final List<String> _dropdownValues1 = [
    "None",
    "Date added",
    "Price: Low to High",
    "Price: High to Low",
  ];

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: SingleChildScrollView(
        child: Column(children: [
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

          //*********FIRST FILTER: DROPDOWN***********/
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
              borderRadius:
                  BorderRadius.circular(20.0), //borderRadius for dropdownMenu
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
                switch (kind) {
                  case "None":
                    sort = null;
                    break;
                  case "Date added":
                    sort = const Sort(Kind.date, Direction.descending);
                    break;
                  case "Price: Low to High":
                    sort = const Sort(Kind.price, Direction.descending);
                    break;
                  case "Price: High to Low":
                    sort = const Sort(Kind.price, Direction.ascending);
                    break;
                }

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
                "Price Range:",
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
                    controller: minController,
                    keyboardType: TextInputType.number,
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
                    controller: maxController,
                    keyboardType: TextInputType.number,
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
                "Display:",
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
                CheckboxListTile(
                  title: const Text('Favourited Bids'),
                  value: showSBids,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (bool? value) {
                    setState(() {
                      showSBids = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Non-favourited Bids'),
                  value: showBids,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (bool? value) {
                    setState(() {
                      showBids = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          //*******************************************/

          const Padding(padding: EdgeInsets.all(10)),

          //*****************BUTTONS*******************/

          StoreConnector<AppState, _ViewModel>(
            vm: () => _Factory(widget),
            builder: (BuildContext context, _ViewModel vm) => ButtonWidget(
              text: "Apply",
              function: () {
                //if the min and max values are actually used
                if (minController.text.isNotEmpty &&
                    maxController.text.isNotEmpty) {
                  //make sure that min <= max
                  // int.parse(minController.text) > int.parse(maxController.text)
                  //     ? displayToastError(
                  //         context, "Min field must be less than Max field")
                  //     : vm.dispatchFilterBidsAction(
                  //         FilterBidsModel(
                  //           includeShortlisted: showSBids,
                  //           includeBids: showBids,
                  //           priceRange: minController.value.text.isEmpty ||
                  //                   maxController.value.text.isEmpty
                  //               ? null
                  //               : Range(
                  //                   int.parse(minController.value.text),
                  //                   int.parse(maxController.value.text),
                  //                 ),
                  //           sort: sort,
                  //         ),
                  //       );
                  Navigator.pop(context);
                  //if the min and max values aren't used
                } else {
                  // vm.dispatchFilterBidsAction(
                  //   FilterBidsModel(
                  //     includeShortlisted: showSBids,
                  //     includeBids: showBids,
                  //     priceRange: minController.value.text.isEmpty ||
                  //             maxController.value.text.isEmpty
                  //         ? null
                  //         : Range(
                  //             int.parse(minController.value.text),
                  //             int.parse(maxController.value.text),
                  //           ),
                  //     sort: sort,
                  //   ),
                  // );
                  Navigator.pop(context);
                }
              },
            ),
          ),
          ButtonWidget(
              text: "Cancel",
              color: "light",
              border: "white",
              function: () {
                Navigator.pop(context);
              } //need a different function
              ),

          //*******************************************/
          const Padding(padding: EdgeInsets.all(20))
        ]),
      ),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, FilterPopUpWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchFilterBidsAction: (FilterBidsModel filter) =>
            dispatch(FilterBidsAction(filter)),
      );
}

// view model
class _ViewModel extends Vm {
  final void Function(FilterBidsModel) dispatchFilterBidsAction;

  _ViewModel({
    required this.dispatchFilterBidsAction,
  }); // implementinf hashcode
}
