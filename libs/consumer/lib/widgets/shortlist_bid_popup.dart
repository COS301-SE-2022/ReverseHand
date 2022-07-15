import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';

class ShortlistPopUpWidget extends StatelessWidget {
  const ShortlistPopUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(25),
          child: const Text(
            "Are you sure you want to shortlist this bid?\n\n The relevant Contractor will be notified to send a detailed quote.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWidget(text: "Shortlist", function: () {}),
            const Padding(padding: EdgeInsets.all(5)),
            ButtonWidget(
              text: "Cancel",
              function: () {},
              color: "light",
            )
          ],
        )
      ],
    );
  }
}
