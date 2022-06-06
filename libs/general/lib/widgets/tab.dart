import 'package:flutter/material.dart';

class TabWidget extends StatefulWidget {
  final String text;
  const TabWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<TabWidget> createState() => _State();
}

class _State extends State<TabWidget> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => setState(() => flag = !flag),
      style: ElevatedButton.styleFrom(
          primary: flag
              ? Theme.of(context).primaryColor
              : Theme.of(context).scaffoldBackgroundColor,
          textStyle: const TextStyle(fontSize: 25),
          minimumSize: const Size(178, 50),
          maximumSize: const Size(178, 50),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(widget.text),
      ),
    );
  }
}
