import 'package:flutter/material.dart';

//used in consumer and tradesman

class LoadingWidget extends StatelessWidget {
  final double padding;
  const LoadingWidget({Key? key, required this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: const CircularProgressIndicator(
          color: Colors.orange,
      ),
    );
  }
}
