import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';

class ProvinceSelectWidget extends StatefulWidget {
  const ProvinceSelectWidget({Key? key}) : super(key: key);

  final List<String> provinces = const [
    "Eastern Cape",
    "Free State",
    "Gauteng",
    "KwaZulu-Natal",
    "Limpopo",
    "Mpumalanga",
    "Northern Cape",
    "North West",
    "Western Cape"
  ];
  @override
  State<ProvinceSelectWidget> createState() => _RadioSelectWidgetState();
}

class _RadioSelectWidgetState extends State<ProvinceSelectWidget> {
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
          'Select a Province:',
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
          children: widget.provinces
              //**********************select options *************** */
              .map((tradeType) => ListTile(
                    title: Text(
                      tradeType,
                      style: const TextStyle(
                        color: Colors.white,
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
      ),
      //***********************buttons******************** */
      actions: [
        Center(
          child: Column(
            children: [
              ButtonWidget(text: "Submit", function: _submit),
              ButtonWidget(text: "Cancel", color: "light", function: _cancel)
            ],
          ),
        ),
      ],
      //************************************************ */
    );
  }
}
