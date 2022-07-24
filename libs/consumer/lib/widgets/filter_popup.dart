import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';

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
                width: 1),
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
                title: const Text('Shortlisted Bids'),
                value: true,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (value) {},
              ),
              CheckboxListTile(
                title: const Text('Non-shortlisted Bids'),
                value: true,
                activeColor: Theme.of(context).primaryColor,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
        //*******************************************/

        const Padding(padding: EdgeInsets.all(10)),

        //*****************BUTTONS*******************/
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

        //*******************************************/
        const Padding(padding: EdgeInsets.all(20))
      ]),
    );
  }
}
