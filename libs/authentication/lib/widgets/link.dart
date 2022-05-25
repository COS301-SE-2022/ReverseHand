import 'package:flutter/material.dart';

class LinkWidget extends StatelessWidget {
  final String text; 
  const LinkWidget({Key? key, required this.text}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            'Don\'t have an account? ',
            style: TextStyle(
              fontSize: 17,
              color: Color(0xfff5fffa),
            ),
            softWrap: false,
          ),
        ),
        Center(
          child: Text(
            'Sign Up', //edit this to use parameter value
            style: TextStyle(
              fontSize: 17,
              color: Theme.of(context).primaryColor,
            ),
            softWrap: false,
          ),
        ),
      ],
    );
  }
}
