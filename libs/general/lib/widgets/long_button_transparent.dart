import 'package:flutter/material.dart';

class TransparentLongButtonWidget extends StatelessWidget {
  final String text;
  final Color? borderColor;
  final void Function() function;

  const TransparentLongButtonWidget({
    Key? key,
    required this.text,
    this.borderColor,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shadowColor: Colors.black,
          elevation: 9,
          side: BorderSide(color: borderColor ?? Colors.orange),
          textStyle: const TextStyle(fontSize: 20),
          minimumSize: const Size(400, 50),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
        ),
        onPressed: function,
        child: Text(text),
      ),
    );
  }
}
