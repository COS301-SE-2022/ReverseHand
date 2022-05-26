import 'package:flutter/material.dart';

class LongButtonWidget extends StatelessWidget {
  final String text; 
  const LongButtonWidget({Key? key, required this.text}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290,
      height: 90,
      child: Column(
      children: <Widget>[
        ElevatedButton(
          child: const Text("LOGIN"), //change to use parameter here
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            onPrimary: Colors.white,
            shadowColor: Colors.black,
            elevation: 9,
            textStyle: const TextStyle(fontSize: 20),
            minimumSize: const Size(400, 50),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30.0))),
          ),
          onPressed: () {
            
          },
        ),
      ],
      ),
    );
  }
}
