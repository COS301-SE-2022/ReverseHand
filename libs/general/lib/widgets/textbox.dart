import 'package:flutter/material.dart';

class TextboxWidget extends StatelessWidget {
  final String text;
  const TextboxWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.all(12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border:
            Border.all(color: const Color.fromRGBO(255, 153, 0, 1), width: 2.0),
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 25, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
