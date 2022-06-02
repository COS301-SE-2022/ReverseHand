import 'package:flutter/material.dart';

class PopupWidget extends StatelessWidget {
  
  const PopupWidget({
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
      ),
      child: Column(
        children: const <Widget>[
          Text("Title Here"),
          Text("Subtitle Here"),
        ],
      ),
    );
  }
}
