// What is held in the toast for success messages

import 'package:flutter/material.dart';

class ToastSuccessWidget extends StatelessWidget {
  final String msg;

  const ToastSuccessWidget(this.msg, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Text(
        msg,
        textAlign: TextAlign.center,
      ),
    );
  }
}
