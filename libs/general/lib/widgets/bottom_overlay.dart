import 'package:flutter/material.dart';

//used in consumer and tradesman

class BottomOverlayWidget extends StatelessWidget {
  final double height;
  const BottomOverlayWidget({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorDark,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        boxShadow: const [
          BoxShadow(color: Colors.black, spreadRadius: 0.5, blurRadius: 3),
        ],
      ),
    );
  }
}
