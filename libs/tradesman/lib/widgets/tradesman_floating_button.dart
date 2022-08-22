import 'package:flutter/material.dart';

class TradesmanFloatingButtonWidget extends StatelessWidget {
  final void Function() function;
  final String type;
  const TradesmanFloatingButtonWidget(
      {Key? key, required this.function, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: function,
      backgroundColor: Colors.orange,
      child: type == "filter"
          ? const Icon(Icons.filter_alt)
          : const Icon(Icons.add),
    );
  }
}
