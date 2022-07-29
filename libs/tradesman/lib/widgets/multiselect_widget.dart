import 'package:flutter/material.dart';

class MultiSelectWidget extends StatefulWidget {
  final List<String> items; //list of types
  final List<String> selectedItems; //list of types
  const MultiSelectWidget({Key? key, required this.items, required this.selectedItems}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectWidgetState();
}

class _MultiSelectWidgetState extends State<MultiSelectWidget> {


  //triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        widget.selectedItems.add(itemValue);
      } else {
        widget.selectedItems.remove(itemValue);
      }
    });
  }

  //**************Button methods**************** */
  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, widget.selectedItems);
  }
  //******************************************* */

  @override
  Widget build(BuildContext context) {
    /*******************MuliSelect popup widget************* */
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
          children: widget.items
          //**********************select options *************** */
              .map((item) => CheckboxListTile(
                    value: widget.selectedItems.contains(item),
                    activeColor: Colors.orange,
                    selected: (widget.selectedItems.contains(item)) ? true : false,
                    title: Text(
                      item,  
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
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
    //*************************************************** */
  }
}
