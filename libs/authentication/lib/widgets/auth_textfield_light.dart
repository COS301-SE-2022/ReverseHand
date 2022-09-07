import 'package:flutter/material.dart';

//******************************** */
//  login and signup textfields
//******************************** */

class AuthTextFieldLightWidget extends StatelessWidget {
  final String label;
  final bool obscure;
  final IconData? icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function()? onTap;

  const AuthTextFieldLightWidget({
    Key? key,
    required this.label,
    required this.obscure,
    this.icon,
    required this.controller,
    this.validator, 
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder focused = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Colors.orange,
        width: 2.0,
      ),
    );

    OutlineInputBorder unfocused = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Colors.grey,
        width: 2,
      ),
    );

    return TextFormField(
      style: const TextStyle(color: Colors.white),
      validator: validator,
      obscureText: obscure,
      controller: controller,
      onTap: onTap,
      decoration: InputDecoration(
          // for errros
          errorStyle: const TextStyle(color: Colors.red),
          errorBorder: unfocused,
          focusedErrorBorder: focused,

          // lack of errors
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          filled: true,
          fillColor: Theme.of(context).primaryColorLight.withOpacity(0.8),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          enabledBorder: unfocused,
          focusedBorder: focused),
    );
  }
}
