import 'package:flutter/material.dart';

class QuoteWidget extends StatelessWidget {
  const QuoteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 50.0, bottom: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shadowColor: Colors.black,
          elevation: 9,
          textStyle: const TextStyle(fontSize: 20),
          minimumSize: const Size(200, 50),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
        ),
        onPressed: () {},
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            children: const [
              Icon(
                Icons.file_copy_rounded,
                color: Colors.black,
                size: 25.0,
              ),
              Padding(padding: EdgeInsets.all(2)),
              Text(
                "Download Quote",
                style: TextStyle(fontSize: 25, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
