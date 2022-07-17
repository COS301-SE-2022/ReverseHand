import 'package:flutter/material.dart';
import 'package:general/general.dart';

class LoadWidget extends StatelessWidget {
  const LoadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(50),
      //   color: CustomTheme.darkTheme.primaryColor,
      // ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: const CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 15,
        ),
      ),
    );
  }
}
