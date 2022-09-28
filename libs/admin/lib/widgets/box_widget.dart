import 'package:flutter/material.dart';

class BoxWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() function;

  const BoxWidget({
    Key? key,
    required this.text,
    required this.icon,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: Container(
        margin: const EdgeInsets.all(5),
        height: MediaQuery.of(context).size.height / 2.75,
        width: MediaQuery.of(context).size.width / 2.25,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextButton.icon(
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith(
                (states) => Colors.orangeAccent.withOpacity(0.3)),
          ),
          label: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          icon: Icon(
            icon,
            color: Colors.orange,
            size: 40,
          ),
          onPressed: function,
        ),
      ),
    );
  }
}
