import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';
import 'package:general/widgets/textfield.dart';

//used in consumer and tradesman

class BottomSheetWidget extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final String? initialVal;
  const BottomSheetWidget(
      {Key? key, required this.controller, required this.text, this.initialVal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        color: Theme.of(context).primaryColorDark,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 180,
              child: Column(
                children: [
                  Text(text,
                      style: const TextStyle(
                        fontSize: 20,
                      )),
                  const Padding(padding: EdgeInsets.all(10)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFieldWidget(
                        label: "",
                        obscure: false,
                        min: 1,
                        initialVal: initialVal,
                        controller: controller),
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  ButtonWidget(text: "Save", function: () {})
                ],
              ),
            )),
      ),
    );
  }
}
