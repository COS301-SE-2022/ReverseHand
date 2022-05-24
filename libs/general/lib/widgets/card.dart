// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String titleText; // const CardWidget({Key? key
  // }) : super(key: key);
  const CardWidget({Key? key, required this.titleText}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(35, 47, 62, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 2,
      child: Column(
        children: [
          ListTile(
            title: Text(
              titleText,
              style: const TextStyle(fontSize: 25.0, color: Colors.white),
            ),
            subtitle: const Text(
              "test2",
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
