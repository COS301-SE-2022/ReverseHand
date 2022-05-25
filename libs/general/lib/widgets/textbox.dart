import 'package:flutter/material.dart';

class TextboxWidget extends StatelessWidget {
  const TextboxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 70,
      padding: const EdgeInsets.all(12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(255, 153, 0, 1), width: 4.0),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      ),
      child: const Text(
        "First Bid",
        style: TextStyle(fontSize: 32, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
