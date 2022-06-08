import 'package:flutter/material.dart';

class ShortlistAcceptButtonWidget extends StatefulWidget {
  VoidCallback onTap;
  ShortlistAcceptButtonWidget({Key? key, required this.onTap})
      : super(key: key);

  @override
  State<ShortlistAcceptButtonWidget> createState() => _State();
}

class _State extends State<ShortlistAcceptButtonWidget> {
  bool displayShortlist = true;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onTap,
      style: ElevatedButton.styleFrom(
          primary: const Color.fromRGBO(255, 153, 0, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          )),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          displayShortlist ? "SHORTLIST" : "ACCEPT",
          style: const TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}
