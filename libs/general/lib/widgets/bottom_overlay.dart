import 'package:flutter/material.dart';

class BottomOverlayWidget extends StatelessWidget {
  final double height;
  const BottomOverlayWidget({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(70)),
        boxShadow: const [
          BoxShadow(color: Colors.black, spreadRadius: 1, blurRadius: 3),
        ],
      ),
    );
  }
}
