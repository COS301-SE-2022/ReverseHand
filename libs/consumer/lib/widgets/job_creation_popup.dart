import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';

class CreationPopupWidget extends StatelessWidget {
  const CreationPopupWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20,40,20,20),
          child: const Text(
            "Title and trade types must be entered to create a job.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 22),
          ),
        ),
        ButtonWidget(text: "Got it", function: () => Navigator.pop(context))
      ],
    );
  }
}
