import 'package:flutter/material.dart';

class HintWidget extends StatelessWidget {
  final String text;
  const HintWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            color: Colors.white70,
            size: 20,
          ),
          const Padding(padding: EdgeInsets.all(3)),
          Text(
            text,
            style: const TextStyle(color: Colors.white70),
          )
        ],
      ),
    );
  }
}
