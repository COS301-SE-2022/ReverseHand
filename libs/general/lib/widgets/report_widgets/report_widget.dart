import 'package:flutter/material.dart';

class ReportWidget extends StatefulWidget {
  const ReportWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //*****************CLOSE****************//
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context, null);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              )),
        ),
        //**************************************//

        //******************TEXT****************//
        const Text(
          "Select a reason for this report:",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        //**************************************//

        //***************DROPDOWN**************//
        const Padding(padding: EdgeInsets.only(top: 10)),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
          width: MediaQuery.of(context).size.width / 1.5,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: DropdownButton(
            // Initial Value
            value: dropdownvalue,
            icon: const Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
            ),
            dropdownColor: Theme.of(context).primaryColorDark,
            borderRadius: BorderRadius.circular(20.0),
            isExpanded: true,
            underline: const SizedBox.shrink(),
            // Array list of items
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              dropdownvalue = newValue!;
            },
          ),
        )
        //**************************************//

        //******************DESC****************//

        //**************************************//
      ],
    );
  }
}
