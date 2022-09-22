// What is held in the toast

import 'package:flutter/material.dart';

class ToastErrorWidget extends StatelessWidget {
  final String msg;

  const ToastErrorWidget(this.msg, {Key? key}) : super(key: key);

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
