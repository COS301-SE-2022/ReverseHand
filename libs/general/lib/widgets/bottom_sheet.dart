import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';

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
    if (initialVal != null) {
      controller.text = initialVal!;
    }
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 180,
              child: Column(
                children: [
                  Text(text,
                      style:
                          const TextStyle(fontSize: 20, color: Colors.black)),
                  const Padding(padding: EdgeInsets.all(10)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      minLines: 1,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      obscureText: false,
                      controller: controller,
                      onTap: () {},
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(
                            color: Colors.orange,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
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
