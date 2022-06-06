import 'package:flutter/material.dart';

class QuickViewBidWidget extends StatelessWidget {
  final String name;
  final void Function() onTap;
  const QuickViewBidWidget({Key? key, required this.onTap, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                  color: const Color.fromRGBO(255, 153, 0, 1), width: 2.0),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            ),
            child: const Text(
              "Mr J Smith",
              style: TextStyle(fontSize: 25, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}
