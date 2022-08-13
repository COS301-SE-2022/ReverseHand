import 'package:flutter/material.dart';


class TradesmanFloatingButtonWidget extends StatelessWidget {
  final void Function() function;
  const TradesmanFloatingButtonWidget({Key? key, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: function,
      backgroundColor: Colors.orange,
      child: const Icon(Icons.filter_alt),
    );
  }
}
