import 'package:flutter/material.dart';

class TransparentDividerWidget extends StatelessWidget {
  const TransparentDividerWidget({Key? key}) : super(key: key);

//************************************************* */
// Padding without using padding. She needs to go
//************************************************** */

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 20,
      thickness: 0.5,
      indent: 15,
      endIndent: 10,
      color: Colors.transparent,
    );
  }
}
