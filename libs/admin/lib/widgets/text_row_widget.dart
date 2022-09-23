import 'package:flutter/material.dart';

class TextRowWidget extends StatelessWidget {
  final String text;
  final String value;
  const TextRowWidget({Key? key, required this.text, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Text(
              value,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
