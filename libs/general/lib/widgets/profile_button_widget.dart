import 'package:flutter/material.dart';

class ProfileButtonWidget extends StatelessWidget {
  final String text;
  final void Function() function;
  final bool? waiting;
  final double width;
  final double height;
  final IconData? icon;
  const ProfileButtonWidget({Key? key, required this.text, required this.function, this.waiting, required this.width, required this.height, required this.icon})
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
        label: Align(alignment: Alignment.centerLeft, child: Text(text, style: const TextStyle(fontSize: 17),)),
        style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(18, 26, 34, 1),
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: const BorderSide(color: Colors.grey, width: 1),
          )),
        onPressed: function,
        ),
    );
  }
}
