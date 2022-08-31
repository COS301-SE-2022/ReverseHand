import 'package:flutter/material.dart';

//used in consumer and tradesman

class ButtonWidget extends StatelessWidget {
  final String text;
  final String?
      color; //blue or scaffold colour, depending on background - orange is default
  final void Function() function;
  final bool? waiting;
  // final bool? whiteBorder; //white border and lower opacity
  final String? border;
  const ButtonWidget(
      {Key? key,
      required this.text,
      this.color,
      required this.function,
      this.waiting,
      this.border})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color == "dark"
              ? Theme.of(context).scaffoldBackgroundColor
              : color == "light"
                  ? Theme.of(context).primaryColorDark
                  : const Color.fromRGBO(255, 153, 0, 1),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1.2,
                color: border == "white"
                    ? Colors.white70
                    : border == "lightBlue"
                        ? Theme.of(context).primaryColorDark
                        : const Color.fromRGBO(255, 153, 0, 1)),
            borderRadius: BorderRadius.circular(15.0),
          )),
      onPressed: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
              color: border == "white" ? Colors.white70 : Colors.white,
              fontSize: 20),
        ),
      ),
    );
  }
}
