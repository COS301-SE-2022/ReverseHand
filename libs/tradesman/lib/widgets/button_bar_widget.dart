import 'package:flutter/material.dart';

class ButtonBarTitleWidget extends StatelessWidget {

  final String title;
  final String value;

  const ButtonBarTitleWidget(
      {Key? key,
      required this.title,
      required this.value,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //general shape and shadows
    return ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
              title,
              style: const TextStyle(
                  fontFamily: 'Futura',
                  fontSize: 23,
                  color: Colors.white
              )
          ),
          Text(
            value,
            style: const TextStyle(
                fontFamily: 'Futura',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white
            )
          ),
         
        ],
    );
  }
}


