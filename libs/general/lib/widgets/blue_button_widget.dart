import 'package:flutter/material.dart';

//refactor this

class BlueButtonWidget extends StatelessWidget {
  final String text;
  final void Function() function;
  final bool? waiting;
  final double width;
  final double height;
  final IconData? icon;
  const BlueButtonWidget(
      {Key? key,
      required this.text,
      required this.function,
      this.waiting,
      required this.width,
      required this.height,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.blueGrey,
        ),
        label: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: const TextStyle(fontSize: 17),
            )),
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, 
            backgroundColor: Colors.black.withOpacity(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: const BorderSide(color: Colors.grey, width: 1),
            )),
        onPressed: function,
      ),
    );
  }
}
