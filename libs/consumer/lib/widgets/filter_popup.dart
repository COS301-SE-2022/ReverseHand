import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';

import 'package:redux_comp/actions/bids/shortlist_bid_action.dart';
import 'package:redux_comp/app_state.dart';

class FilterPopUpWidget extends StatelessWidget {
  final List<String> _dropdownValues1 = [
    "Date added",
    "Price: Low to High",
    "Price: High to Low",
  ];
  FilterPopUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const Padding(
          padding: EdgeInsets.only(left: 45, top: 30),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Sort By",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        Container(
          padding: const EdgeInsets.all(10),
          height: 40,
          width: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius:
                BorderRadius.circular(20.0), //borderRadius for container
            border: Border.all(
                color: Colors.white, style: BorderStyle.solid, width: 1),
          ),
          child: DropdownButton(
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              borderRadius:
                  BorderRadius.circular(20.0), //borderRadius for dropdownMenu
              isExpanded: true,
              underline: const SizedBox.shrink(),
              value: _dropdownValues1.first,
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
              onChanged: ((_) {})),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 45, top: 20),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Price Range",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10)),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //MINIMUM TEXTFIELD
            Container(
                height: 40,
                width: (MediaQuery.of(context).size.width / 1.7) / 2,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius:
                      BorderRadius.circular(20.0), //borderRadius for container
                ),
                child: TextFormField(
                  // initialValue: "0",
                  style: const TextStyle(color: Colors.white),
                  controller: null,
                  decoration: InputDecoration(
                    labelText: "min",
                    labelStyle: const TextStyle(color: Colors.white),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.white,
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
                  borderRadius:
                      BorderRadius.circular(20.0), //borderRadius for container
                ),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: null,
                  decoration: InputDecoration(
                    labelText: "max",
                    labelStyle: const TextStyle(color: Colors.white),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.white,
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
        const Padding(
          padding: EdgeInsets.only(left: 45, top: 20),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Display",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        //*******************************************//

        const Padding(padding: EdgeInsets.all(10)),

        // Buttons
        ButtonWidget(text: "Apply", function: () {} //need a different function
            ),
        ButtonWidget(
            text: "Cancel",
            color: "light",
            border: "white",
            function: () {
              Navigator.pop(context);
            } //need a different function
            ),

        const Padding(padding: EdgeInsets.all(20))
      ]),
    );
  }
}

// factory for view model
class _Factory extends VmFactory<AppState, FilterPopUpWidget> {
  _Factory(widget) : super(widget);

  @override
  _ViewModel fromStore() => _ViewModel(
        dispatchShortListBidAction: () => dispatch(ShortlistBidAction()),
      );
}

// view model
class _ViewModel extends Vm {
  final VoidCallback dispatchShortListBidAction;

  _ViewModel({
    required this.dispatchShortListBidAction,
  }); // implementinf hashcode
}
