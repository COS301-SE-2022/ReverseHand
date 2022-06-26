import 'package:flutter/material.dart';

class MultiSelectWidget extends StatefulWidget {
  final List<String> items; //list of types
  const MultiSelectWidget({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectWidgetState();
}

class _MultiSelectWidgetState extends State<MultiSelectWidget> {
  final List<String> _selectedItems = []; //sleected items

  //triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  //**************Button methods**************** */
  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedItems);
  }
  //******************************************* */

  @override
  Widget build(BuildContext context) {
    /*******************MuliSelect popup widget */
    return AlertDialog(
      title: const Text('Select Trade Type'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
          //**********************select options *************** */
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(
                      item,  
                      style: const TextStyle(
                        color: Colors.black,
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
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
      //************************************************ */
    );
    //*************************************************** */
  }
}
