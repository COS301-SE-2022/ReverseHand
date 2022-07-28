import 'package:flutter/material.dart';


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
      title: const Text(
        'Select Trade Type',
        style: TextStyle(
          color: Colors.white,
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
              .map((tradeType) => ListTile(
                  title: Text(tradeType,
                  style: const TextStyle(color: Colors.white,),),
                  leading: Radio<String>(
                    value: tradeType,
                    groupValue: _trade,
                    fillColor: MaterialStateColor.resolveWith((states) => Colors.orange),
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
      ),
      //***********************buttons******************** */
      actions: [
        TextButton(
          onPressed: _cancel,
          style: TextButton.styleFrom(
            primary: Colors.orange,
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent, // Background color
            onPrimary: Colors.white, // Text Color (Foreground color)
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: const BorderSide(color: Colors.orange, width: 1),
          )),
          child: const Text('Submit'),
          ),
      ],
      //************************************************ */
    );
  }
}




