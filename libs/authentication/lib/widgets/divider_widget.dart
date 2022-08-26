import 'package:flutter/material.dart';


//******************************** */
// 'OR' divider for login and signup
//******************************** */

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 20,
      thickness: 0.5,
      indent: 10,
      endIndent: 10,
      color: Color.fromRGBO(255, 255, 255, 1),
    );
  }
}

//check if this can be deleted
