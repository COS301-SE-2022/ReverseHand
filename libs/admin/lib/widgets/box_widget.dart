import 'package:flutter/material.dart';

class BoxWidget extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;
  final void Function() function;

  const BoxWidget({
    Key? key,
    required this.text,
    required this.color,
    required this.icon,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      height: MediaQuery.of(context).size.height / 2.75,
      width: MediaQuery.of(context).size.width / 2.25,
      decoration: BoxDecoration(
        color: color.withOpacity(0.95),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextButton.icon(
        label: Text(text, style: const TextStyle(color: Colors.white)),
        icon: Icon(
          icon,
          color: Colors.white,
          size: 50,
        ),
        onPressed: function,
      ),
    );
  }
}
