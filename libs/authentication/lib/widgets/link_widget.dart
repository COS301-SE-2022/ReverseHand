import 'package:flutter/material.dart';

//******************************** */
//link text with onTap for navigation
//******************************** */

class LinkWidget extends StatelessWidget {
  final String text1; 
  final String text2; 
  final void Function() navigate;
  const LinkWidget({Key? key, required this.text1, required this.text2, required this.navigate}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            text1,
            style: const TextStyle(
              fontSize: 17,
              color: Color(0xfff5fffa),
            ),
            softWrap: false,
          ),
          GestureDetector(
            onTap: navigate,
            child: Text(
              text2,
              style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).primaryColor,
              ),
              softWrap: false,
            ),
          ),
      ],
    );
  }
}
