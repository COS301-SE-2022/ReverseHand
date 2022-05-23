import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(255, 153, 0, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          )),
      onPressed: () {}, //destination must still be implemented
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'ACCEPT BID',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
