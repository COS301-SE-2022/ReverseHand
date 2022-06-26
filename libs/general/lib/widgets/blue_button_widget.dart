import 'package:flutter/material.dart';

class BlueButtonWidget extends StatelessWidget {
  final String text;
  final void Function() function;
  final bool? waiting;
  const BlueButtonWidget({Key? key, required this.text, required this.function, this.waiting})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150, 
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: const Color.fromRGBO(18, 26, 34, 1),
            side: const BorderSide(width: 2, color: Color.fromARGB(110, 160, 160, 160)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            shadowColor: const Color.fromARGB(0, 0, 0, 0),
        ),
        onPressed: function,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
