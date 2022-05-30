// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String titleText;
  final String price;
  final String details; // const CardWidget({Key? key
  // }) : super(key: key);
  const CardWidget(
      {Key? key,
      required this.titleText,
      required this.price,
      required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: const Color.fromRGBO(35, 47, 62, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(titleText,
                    style: const TextStyle(fontSize: 30, color: Colors.white)),
                const SizedBox(height: 4),
                const Text("Contact Details: ",
                    style: TextStyle(fontSize: 20, color: Colors.white70)),
                Text(details,
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
                Padding(padding: EdgeInsets.all(5)),
                const Text("Quoted price: ",
                    style: TextStyle(fontSize: 20, color: Colors.white70)),
                Text(price,
                    style: const TextStyle(fontSize: 20, color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
