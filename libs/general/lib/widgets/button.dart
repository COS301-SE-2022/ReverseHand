import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final void Function() function;
  final bool? waiting;
  final bool? transparent;
  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.function,
      this.waiting,
      this.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: transparent == true
              ? Theme.of(context).scaffoldBackgroundColor
              : const Color.fromRGBO(255, 153, 0, 1),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                width: 1.2, color: Color.fromRGBO(255, 153, 0, 1)),
            borderRadius: BorderRadius.circular(30.0),
          )),
      onPressed: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
