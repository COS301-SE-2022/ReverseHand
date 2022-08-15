import 'package:flutter/material.dart';


//******************************** */
//  login and signup long button
//******************************** */

class AuthButtonWidget extends StatelessWidget {
  final String text;
  final void Function() function;
  final double width;
  final double height;

  const AuthButtonWidget(
      {Key? key,
      required this.text,
      required this.function,
      this.width = 290,
      this.height = 70})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
              onPrimary: Colors.white,
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
