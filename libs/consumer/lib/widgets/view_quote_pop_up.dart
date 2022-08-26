import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';

class QuotePopUpWidget extends StatelessWidget {
  const QuotePopUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "QUOTE",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ButtonWidget(text: "Close", function: () {})
        ],
      ),
    );
  }
}
