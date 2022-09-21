import 'package:flutter/material.dart';
import 'package:general/widgets/button.dart';

//used in consumer and tradesman

class BottomSheetWidget extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final String? initialVal;
  final void Function() function;
  const BottomSheetWidget(
      {Key? key,
      required this.controller,
      required this.text,
      required this.function,
      this.initialVal})
      : super(key: key);

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    // if (widget.initialVal != null) {
    //   widget.controller.text = widget.initialVal!;
    // }
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 210,
              child: Column(
                children: [
                  Text(
                    widget.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autofocus: true,
                      minLines: 1,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      obscureText: false,
                      controller: widget.controller,
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
                  ButtonWidget(text: "Save", function: widget.function)
                ],
              ),
            )),
      ),
    );
  }
}
