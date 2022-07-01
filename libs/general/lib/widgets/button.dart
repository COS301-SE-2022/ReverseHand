import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final String? color;
  final void Function() function;
  final bool? waiting;
  final bool? transparent; //no background
  final bool? whiteBorder; //white border and lower opacity
  const ButtonWidget(
      {Key? key,
      required this.text,
      this.color,
      required this.function,
      this.waiting,
      this.transparent,
      this.whiteBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color == "dark"
              ? Theme.of(context).scaffoldBackgroundColor
              : color == "light"
                  ? Theme.of(context).primaryColorDark
                  : const Color.fromRGBO(255, 153, 0, 1),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1.2,
                color: whiteBorder == true
                    ? Colors.white70
                    : const Color.fromRGBO(255, 153, 0, 1)),
            borderRadius: BorderRadius.circular(30.0),
          )),
      onPressed: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
              color: whiteBorder == true ? Colors.white70 : Colors.white,
              fontSize: 20),
        ),
      ),
    );
  }
}
