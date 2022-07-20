import 'package:flutter/material.dart';
import 'package:general/general.dart';

class LoadWidget extends StatelessWidget {
  const LoadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        height: 100,
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: CircularProgressIndicator(
            color: CustomTheme.darkTheme.primaryColor,
            strokeWidth: 15,
          ),
        ),
      ),
    );
  }
}
