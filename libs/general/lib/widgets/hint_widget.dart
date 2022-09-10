import 'package:flutter/material.dart';

class HintWidget extends StatelessWidget {
  final String text;
  final Color colour;
  final double padding;
  const HintWidget({Key? key, required this.text, required this.colour, required this.padding}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(padding, 15, 15, 0),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: colour,
            size: 20,
          ),
          const Padding(padding: EdgeInsets.all(3)),
          Text(
            text,
            style: TextStyle(color: colour),
          )
        ],
      ),
    );
  }
}
