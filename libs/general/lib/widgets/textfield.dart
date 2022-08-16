import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final bool obscure;
  final int min;
  final TextEditingController controller;
  final String? initialVal;
  final Function()? onTap;

  const TextFieldWidget(
      {Key? key,
      required this.label,
      required this.obscure,
      required this.min,
      required this.controller,
      this.initialVal,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (initialVal != null) {
      controller.text = initialVal!;
    }
    return TextFormField(
      minLines: min,
      maxLines: 5,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      obscureText: obscure,
      controller: controller,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.orange,
            width: 2.0,
          ),
        ),
        // prefixIcon: const Icon(
        //   Icons.mail_outline_rounded,
        //   color: Colors.white,
        // ),
      ),
    );
  }
}
