import 'dart:ui';
import 'package:flutter/material.dart';

// creates blur circle effect
class CircleBlurWidget extends StatelessWidget {
  const CircleBlurWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.only(top: 2),
      alignment: Alignment.topLeft,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(243, 157, 55, 1),
        borderRadius: BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 60.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
        ),
      ),
    );
  }
}
