import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropDownOptionsWidget extends StatefulWidget {
  final String title;
  String currentItem;
  final Map<String, Function> functions;
  DropDownOptionsWidget(
      {Key? key,
      required this.title,
      required this.functions,
      required this.currentItem})
      : super(key: key);

  @override
  State<DropDownOptionsWidget> createState() => _DropDownOptionsWidgetState();
}

class _DropDownOptionsWidgetState extends State<DropDownOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.all(10),
        child: Text(widget.title),
      ),
      DropdownButton<String>(
        value: widget.currentItem,
        dropdownColor: Colors.black,
        items: widget.functions.entries.map<DropdownMenuItem<String>>((item) {
          return DropdownMenuItem<String>(
            value: item.key,
            child: Text(item.key),
          );
        }).toList(),
        onChanged: (String? changed) {
          setState(() {
            widget.currentItem = changed!;
            widget.functions[changed]!();
          });
        },
      ),
    ]);
  }
}
