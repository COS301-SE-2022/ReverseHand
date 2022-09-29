import 'package:flutter/material.dart';

//******************************** */
//  login and signup long button
//******************************** */

class LongButtonWidget extends StatelessWidget {
  final String text;
  final void Function() function;
  final double width;
  final double height;
  final Color backgroundColor;

  const LongButtonWidget({
    Key? key,
    required this.text,
    required this.function,
    this.backgroundColor = Colors.orange,
    this.width = 290,
    this.height = 70,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: backgroundColor,
              shadowColor: Colors.black,
              elevation: 9,
              textStyle: const TextStyle(fontSize: 20),
              minimumSize: const Size(400, 50),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
            ),
            onPressed: function,
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
