// creates a toast with an error message
import 'package:flutter/material.dart';
import 'package:general/widgets/toast_error_widget.dart';

void displayToastError(BuildContext context, String msg) {
  SnackBar snackBar = SnackBar(
    // behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.orange,
    content: ToastErrorWidget(msg),
    duration: const Duration(milliseconds: 1000),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
