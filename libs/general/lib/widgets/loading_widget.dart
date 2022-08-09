import 'package:flutter/material.dart';

//used in consumer and tradesman

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: Colors.orange,
    );
  }
}
