import 'package:flutter/material.dart';

class TextRowWidget extends StatelessWidget {
  final Map<String, String> textValMap;
  const TextRowWidget({Key? key, required this.textValMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Row> rowTextWidgets = [];
    textValMap.forEach((key, value) {
      rowTextWidgets.add(Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
            child: Text(
              key,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Text(
              value,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        ],
      ));
    });
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: rowTextWidgets,
        ));
  }
}
