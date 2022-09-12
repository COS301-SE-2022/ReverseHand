import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';

class RadioSelectWidget extends StatefulWidget {
  const RadioSelectWidget({Key? key}) : super(key: key);

  final List<String> tradeTypes = const [
    "Painting",
    "Tiler",
    "Carpenter",
    "Cleaner",
    "Designer",
    "Landscaper",
    "Electrician",
    "Plumbing",
  ];
  @override
  State<RadioSelectWidget> createState() => _RadioSelectWidgetState();
}

class _RadioSelectWidgetState extends State<RadioSelectWidget> {
  String? _trade;

  //**************Button methods**************** */
  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _trade);
  }
  //******************************************* */

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Select Trade type:",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),),
          ),
          ListBody(
            children: widget.tradeTypes
                //**********************select options *************** */
                .map((tradeType) => ListTile(
                      title: Text(
                        tradeType,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      leading: Radio<String>(
                        value: tradeType,
                        groupValue: _trade,
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => Colors.orange),
                        onChanged: (String? value) {
                          setState(() {
                            _trade = value;
                          });
                        },
                      ),
                    ))
                .toList(),
            //********************************************** */
          ),

          //***********************buttons******************** */
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(text: "Submit", function: _submit),
                const Padding(padding: EdgeInsets.all(5)),
                ButtonWidget(
                  text: "Cancel",
                  function: _cancel,
                  color: "light",
                  border: "lightBlue",
                )
              ],
            ),
          ),
          //************************************************ */
        ],
      ),
    );
  }
}





//  showModalBottomSheet(
//                           context: context,
//                           isScrollControlled: true,
//                           builder: (BuildContext context) {
//                             return const RadioSelectWidget();
//                           });