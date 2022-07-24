import 'package:flutter/material.dart';

class ShortlistAcceptButtonWidget extends StatefulWidget {
  final VoidCallback onTap;
  final bool shortBid;

  const ShortlistAcceptButtonWidget({
    Key? key,
    required this.onTap,
    required this.shortBid,
  }) : super(key: key);

  @override
  State<ShortlistAcceptButtonWidget> createState() => _State();
}

class _State extends State<ShortlistAcceptButtonWidget> {
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
          widget.shortBid ? "Accept Bid" : "Shortlist Bid",
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
