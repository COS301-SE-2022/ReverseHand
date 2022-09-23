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
    return AlertDialog(
      title: const Center(
        child: Text(
          'Select Trade Type:',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: const Color.fromRGBO(35, 47, 62, 1),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.tradeTypes
              //**********************select options *************** */
              .map((tradeType) => RadioListTile(
                    title: Text(
                      tradeType,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    groupValue: _trade,
                    onChanged: (String? value) {
                      setState(() {
                        _trade = value;
                      });
                    },
                    value: tradeType,
                    activeColor: Theme.of(context).primaryColor,
                  ))
              .toList(),
          //********************************************** */
        ),
      ),
      //***********************buttons******************** */
      actions: [
        Center(
          child: Column(
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
      ],
      //************************************************ */
    );
  }
}
