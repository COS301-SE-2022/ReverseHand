import 'package:flutter/material.dart';

//used in consumer and tradesman

class LoadingWidget extends StatelessWidget {
  final double topPadding;
  final double bottomPadding;
  const LoadingWidget({Key? key, required this.topPadding, required this.bottomPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: const CircularProgressIndicator(
          color: Colors.orange,
      ),
    );
  }
}
