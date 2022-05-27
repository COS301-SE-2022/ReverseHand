import 'package:flutter/material.dart';

class LongButtonWidget extends StatelessWidget {
  final String text;
  final void Function() login;
  const LongButtonWidget({Key? key, required this.text, required this.login}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290,
      height: 90,
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
            onPressed: login,
            child: const Text("LOGIN"),
          ),
        ],
      ),
    );
  }
}
